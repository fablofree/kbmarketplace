<?php
/**
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future.If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 * We offer the best and most useful modules PrestaShop and modifications for your online store.
 *
 * @author    knowband.com <support@knowband.com>
 * @copyright 2017 Knowband
 * @license   see file: LICENSE.txt
 * @category  PrestaShop Module
 */

require_once(_PS_ROOT_DIR_ . '/init.php');

class KbmarketplaceCronModuleFrontController extends ModuleFrontController
{
    public $php_self = 'cron';
    
    //function defination to execute first
    public function init()
    {
        parent::init();
        if (!Tools::isEmpty(trim(Tools::getValue('action')))) {
            $action = Tools::getValue('action');
            switch ($action) {
                case 'processPayoutState':
                    $this->processPayoutState();
                    break;
            }
        }
        die;
    }
    
    /*
     * function to execute the process of payout item
     */
    public function processPayoutState()
    {
        if (Tools::getValue('secure_key') == Configuration::get('KB_MP_CRON')) {
            if ($this->processPaypalPayoutState()) {
                echo $this->module->l('Success', 'cron');
            }
        } else {
            echo $this->module->l('Security Token is invalid or expired', 'cron');
        }
    }
    
    /*
     * function to update the payout status
     */
    public function processPaypalPayoutState()
    {
        $str = '';
        if (Tools::getValue('id_seller_transaction')) {
            $str .= ' AND id_seller_transaction='.(int)Tools::getValue('id_seller_transaction');
        }
        $payout_data = Db::getInstance()->executeS('SELECT * FROM '._DB_PREFIX_.'kb_mp_seller_transaction_request WHERE payout_item_id!="" AND (payout_status="PENDING" OR payout_status="PROCESSING" OR payout_status="ACKNOWLEDGED") '.$str);
        if (!empty($payout_data)) {
            foreach ($payout_data as $pay_data) {
                $paypal_setting = Tools::jsonDecode(Configuration::get('KB_MP_PAYOUT_SETTING'), true);
                if (empty($paypal_setting)) {
                    echo $this->module->l('Paypal Configuration is empty.', 'cron');
                } elseif (!$paypal_setting['enable']) {
                    echo $this->module->l('Paypal Configuration is disabled.', 'cron');
                } else {
                    require_once(_PS_MODULE_DIR_ . 'kbmarketplace/libraries/payout/vendor/autoload.php');
                    $apiContext = new \PayPal\Rest\ApiContext(
                        new \PayPal\Auth\OAuthTokenCredential(
                            $paypal_setting['client_id'],
                            $paypal_setting['client_secret']
                        )
                    );
                    $mode = 'sandbox';
                    if ($paypal_setting['mode']) {
                        $mode = 'live';
                    }
                    $apiContext->setConfig(
                        array(
                            'mode' => $mode,
                            'log.LogEnabled' => true,
                            'log.FileName' => '../PayPal.log',
                            'log.LogLevel' => 'DEBUG', // PLEASE USE `INFO` LEVEL FOR LOGGING IN LIVE ENVIRONMENTS
                            'cache.enabled' => false,
                        )
                    );
                    try {
                        $output = \PayPal\Api\PayoutItem::get($pay_data['payout_item_id'], $apiContext);
                        if ($output->_propMap) {
                            $is_approved = 0;
                            $transaction_id = '';
                            if (isset($output->_propMap['transaction_id'])) {
                                $transaction_id = $output->_propMap['transaction_id'];
                                $is_approved = 1;
                                $kbPayoutRequest = new KbSellerTransactionRequest($pay_data['id_seller_transaction']);
                                if ($output->_propMap['transaction_status'] == 'SUCCESS') {
                                    $kbPayoutRequest->approved = '1';
                                } elseif ($output->_propMap['transaction_status'] == 'DENIED') {
                                    $kbPayoutRequest->approved = '2';
                                }
                                $kbPayoutRequest->payout_status = $output->_propMap['transaction_status'];
                                if ($kbPayoutRequest->update()) {
                                    $kbTransaction = new KbSellerTransaction();
                                    $kbTransaction->id_seller = $kbPayoutRequest->id_seller;
                                    $kbTransaction->id_shop = $kbPayoutRequest->id_shop;
                                    $kbTransaction->id_employee = $kbPayoutRequest->id_employee;
                                    $kbTransaction->transaction_number = $transaction_id;
                                    $kbTransaction->amount = $kbPayoutRequest->amount;
                                    $kbTransaction->transaction_type = '0';
                                    $kbTransaction->comment = $kbPayoutRequest->admin_comment;
                                    if ($kbTransaction->add()) {
                                        $this->sendApproveTransactionMail($kbPayoutRequest, $transaction_id, $kbPayoutRequest->admin_comment);
                                    }
                                }
                            } else {
                                if ($output->_propMap['transaction_status'] == 'DENIED') {
                                    $kbPayoutRequest = new KbSellerTransactionRequest($pay_data['id_seller_transaction']);
                                    $kbPayoutRequest->approved = '2';
                                    $kbPayoutRequest->update();
                                }
                            }
                        }
                    } catch (Exception $ex) {
                        echo $ex->getMessage();
                    }
                }
            }
        }
        return true;
    }
    
    /*
     * function to send approve transaction mail to the seller
     */
    public function sendApproveTransactionMail($sellerTransaction, $transaction_id, $comment = null)
    {
        $seller_obj = new KbSeller($sellerTransaction->id_seller);
        $seller_info = $seller_obj->getSellerInfo();
        //send email to Admin
        $template_vars = array(
            '{{shop_title}}' => $seller_info['title'],
            '{{seller_name}}' => $seller_info['seller_name'],
            '{{amount}}' => Tools::displayPrice($sellerTransaction->amount, new Currency($sellerTransaction->id_currency)),
            '{{comment}}' => $comment,
            '{{transaction_id}}' => $transaction_id,
        );
        $email = new KbEmail(
            KbEmail::getTemplateIdByName('mp_seller_payout_transaction_approve_admin'),
            $seller_obj->id_default_lang
        );
        /*Start - MK made change on 30-05-18 to send notification based on the type*/
        $notification_emails = $seller_obj->getEmailIdForNotification();
        foreach ($notification_emails as $em) {
            $email->send(
                $em['email'],
                $em['title'],
                null,
                $template_vars
            );
        }
        /*End - MK made change on 30-05-18 to send notification based on the type*/

        return true;
    }
}
