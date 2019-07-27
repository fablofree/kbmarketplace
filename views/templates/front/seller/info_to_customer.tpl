<style>
.fa {
  padding: 20px;
  font-size: 30px;
  width: 50px;
  text-align: center;
  text-decoration: none;
  margin: 5px 2px;
}

.fa:hover {
    opacity: 0.7;
}

.fa-facebook {
  background: #3B5998;
  color: white;
}

.fa-twitter {
  background: #55ACEE;
  color: white;
}

.fa-google {
  background: #dd4b39;
  color: white;
}

.seller-social2{
        display: inline-block;
    vertical-align: text-bottom;
}

.seller-social2 a{
    padding: 5px 0 3px;
    margin-right: 10px;
  //  background-color: #676767;
    border-radius: 5px;
    display: inline-block;
    width: 30px;
    text-align: center;
   // color: #fff;
    height: 30px;
   // background-size: 30px;
}
</style>

<div class="kb-block seller_profile_view">
    <div class="s-vp-banner">
        <img src="{$seller['banner'] nofilter}" /> {* Variable contains HTML/CSS/JSON, escape not required *}

    </div>
    <div class="info-view">
        <div class="seller-profile-photo">
            <a href="{KbGlobal::getSellerLink($seller['id_seller']) nofilter}" > {* Variable contains HTML/CSS/JSON, escape not required *}

                <img src="{$seller['logo'] nofilter}" title="{$seller['title']}" alt="{$seller['title']}"> {* Variable contains HTML/CSS/JSON, escape not required *}

            </a>
        </div>
{*                whatsapp share*}
            {if (!empty($seller['url_whatsapp'])) }
                <a style="background:  {$seller['color']|escape:'html':'UTF-8'}" class="float whatsapp_2 float-bottom-left float-floating" href="{$seller.url_whatsapp|escape:'html':'UTF-8'}" target="_blank">
                    <i class="whatsapp-icon-3x" style="padding-right:0px!important;"></i>
                </a>
                <div class="label-container label-container-bottom-left float-floating">
                    <i class="icon icon-caret-left label-arrow" style="font-size: x-large;"></i>
                     <div class="label-text">Chat with {$seller['title']}</div>
                </div>
            {/if}
                                
        <div class="seller-info">
            <div class="seller-basic">
                <div class="seller-name">
                    <span class="name">
                        {$seller['title']}
                    </span>
{*                       <div class="seller-rating-block">  
                         {if !isset($seller['is_review_page'])}
                            <div class="kbmp-_inner_block" style="position:relative;">
                                <a href="{$link->getModuleLink($kb_module_name, 'sellerfront', ['render_type' => 'sellerreviews', 'id_seller' => $seller['id_seller']], (bool)Configuration::get('PS_SSL_ENABLED'))|escape:'htmlall':'UTF-8'}" title="{$seller['seller_review_count']|escape:'htmlall':'UTF-8'}">
                                    <div class="vss_seller_ratings">
                                        <!-- Do not customise it -->
                                        <div class="vss_rating_unfilled">★★★★★</div>

                                        <!-- Set only width in percentage according to rating -->
                                        <div class="vss_rating_filled" style="width:{$seller['seller_rating']|escape:'htmlall':'UTF-8'}%">★★★★★</div>
                                    </div>
                                </a>
                            </div>
                            <div class="kbmp-_inner_block"><a href="{$link->getModuleLink($kb_module_name, 'sellerfront', ['render_type' => 'sellerreviews', 'id_seller' => $seller['id_seller']], (bool)Configuration::get('PS_SSL_ENABLED'))|escape:'htmlall':'UTF-8'}" class="vss_active_link vss_read_review_bck"><span class="">{l s='View Reviews' mod='kbmarketplace'}</span></a></div>
                            {if $display_new_review}
                                <div class="kbmp-_inner_block">
                                    {if !$kb_is_customer_logged}
                                        <a href="{$link->getPageLink('my-account', (bool)Configuration::get('PS_SSL_ENABLED'))|escape:'htmlall':'UTF-8'}" class="vss_active_link"><span class="">{l s='Write Review' mod='kbmarketplace'}</span></a>
                                    {else}
                                        <a href="javascript:void(0)" class="vss_active_link vss_write_review_bck" data-toggle="kb-seller-new-review-popup" onclick="openSellerReviewPopup('kb-seller-new-review-popup', false);"><span class="">{l s='Write Review' mod='kbmarketplace'}</span></a>
                                    {/if}
                                </div>
                            {/if}
                        {else}
                            <div class="kbmp-_inner_block"><strong>{l s='Overall Rating' mod='kbmarketplace'}: </strong></div>
                            <div class="kbmp-_inner_block" style="position:relative;">
                                <div class="vss_seller_ratings">
                                    <!-- Do not customise it -->
                                    <div class="vss_rating_unfilled">★★★★★</div>

                                    <!-- Set only width in percentage according to rating -->
                                    <div class="vss_rating_filled" style="width:{$seller['seller_rating']|escape:'htmlall':'UTF-8'}%">★★★★★</div>
                                </div>
                            </div>
                        {/if}        
                    </div>
                </div> *}
                <div class="seller-social2">
                    {if !empty($seller['twit_link'])}
                        <a title="{l s='Twitter' mod='kbmarketplace'}" href="{$seller['twit_link'] nofilter}" class="btn-sm btn-primary social-btn fa fa-twitter" ></a> {* Variable contains HTML/CSS/JSON, escape not required *}

                    {/if}
                    {if !empty($seller['fb_link'])}
                        <a title="{l s='Facebook' mod='kbmarketplace'}" href="{$seller['fb_link'] nofilter}" class="btn-sm btn-primary social-btn fa fa-facebook"></a> {* Variable contains HTML/CSS/JSON, escape not required *}

                    {/if}
                    {if !empty($seller['gplus_link'])}
                        <a title="{l s='Google+' mod='kbmarketplace'}" href="{$seller['gplus_link'] nofilter}" class="btn-sm btn-primary social-btn fa fa-google"></a> {* Variable contains HTML/CSS/JSON, escape not required *}

                    {/if}       
                </div>
            </div>
        </div>
        {if $gdpr_enabled}
            <div class="seller-customer-info-block">
                <div class="seller-basic">
                    <button data-toggle="modal" data-target="#kb-seller-access-data-popup"  class="btn btn-success kb-open-mp-access-popup">{l s='Request to Access Personal Data' mod='kbmarketplace'}</button>
                </div>
            </div>
        {/if}
    </div>
    {if !isset($seller['is_review_page'])}
        {if !empty($seller['description'])}
            <section class="slr-f-box">
                <h3 class="page-product-heading">{l s='About Seller' mod='kbmarketplace'}</h3>
                <div  class="rte slr-content">
                    {$seller['description'] nofilter}  {* Variable contains HTML/CSS/JSON, escape not required *}

                </div>
            </section>
        {/if}

        {*
        <section class="slr-f-box">
            <h3 class="page-product-heading">{l s='Privacy Policy' mod='kbmarketplace'}</h3>
            <div  class="rte slr-content">
                {if !empty($seller['privacy_policy'])}
                    {$seller['privacy_policy'] nofilter}{*Variable contains HTML content,escape not required*/}
                {else}
                    {l s='No Privacy Policy Provided by Seller Yet.' mod='kbmarketplace'}
                {/if}

            </div>
        </section>
        <section class="slr-f-box">
            <h3 class="page-product-heading">{l s='Return Policy' mod='kbmarketplace'}</h3>
            <div  class="rte slr-content">
                {if !empty($seller['return_policy'])}
                    {$seller['return_policy'] nofilter}  {* Variable contains HTML/CSS/JSON, escape not required */}

                {else}
                    {l s='No Return Policy Provided by Seller Yet.' mod='kbmarketplace'}
                {/if}

            </div>
        </section>
        <section class="slr-f-box">
            <h3 class="page-product-heading">{l s='Shipping Policy' mod='kbmarketplace'}</h3>
            <div  class="rte slr-content">
                {if !empty($seller['shipping_policy'])}
                    {$seller['shipping_policy'] nofilter} {* Variable contains HTML/CSS/JSON, escape not required */}

                {else}
                    {l s='No Shipping Policy Provided by Seller Yet.' mod='kbmarketplace'}
                {/if}

            </div>
        </section>
        *}
        {hook h="displayKbSellerView" id_seller=$seller['id_seller'] area="profile"}
    {else}
        {hook h="displayKbSellerView" id_seller=$seller['id_seller'] area="review"}
    {/if}
</div>
{if isset($display_review_popup) && $display_review_popup}
    <div id="kb-seller-new-review-popup" class="modal fade quickview kbpopup-modal" tabindex="-1" role="dialog" style="display:none;">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h2>{l s='Write a review' mod='kbmarketplace'}</h2>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="slr-review-form" action="{KbGlobal::getSellerLink($seller['id_seller']) nofilter}" method="post"> {* Variable contains HTML/CSS/JSON, escape not required *}

                        <input type="hidden" name="new_review_submit" value="1" />
                        <ul>
                            <li>
                                <label>{l s='Rate this Seller' mod='kbmarketplace'}:</label>
                                <div id="seller_new_review_rating_block"></div>
                                <div class="clearfix"></div>
                            </li>
                        </ul>
                        <label for="review_title">{l s='Title' mod='kbmarketplace'}: <sup class="required">*</sup></label>
                        <div class="kb-form-label-block">
                            <input id="review_title" name="review_title" type="text" value="" class="required">
                        </div>
                        <label for="review_content">{l s='Comment' mod='kbmarketplace'}: <sup class="required">*</sup></label>
                        <div class="kb-form-label-block">
                            <textarea id="review_content" name="review_content" class="required"></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <p class="fl required"><sup>*</sup> {l s='Required fields' mod='kbmarketplace'}</p>
                    <p class="fr">
                        <button id="submitSellerReview" type="button" class="btn button button-small" {if $kb_is_customer_logged}onclick="submitSellerNewReview()"{else}onclick="location.href='{$link->getPageLink('my-account', true)|escape:'htmlall':'UTF-8'}'"{/if}>
                            <span>{l s='Submit' mod='kbmarketplace'}</span>
                        </button>
                    </p>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
{/if}
{if $gdpr_enabled}
    <div id="kb-seller-access-data-popup">
        <div class="kb-popup-content">
            <h4 class="page-heading">{l s='Request to Access Personal Data' mod='kbmarketplace'}</h4>
            <p class="kb-page-subheading">{l s='You can request to the seller to provide the report of your personal data they have store by entering the email Id.' mod='kbmarketplace'}</p>
            <form class="kb_mp_personal_access_form" action="{$filter_form_action}" method="post">
                <div class="form-group">
                    <label for="email">{l s='Email Address' mod='kbmarketplace'}</label>
                    <input type="hidden" name="id_seller" value="{$seller['id_seller']}">
                    <input type="text" class="form-control" id="kb_access_email" name="kb_access_email" placeholder="{l s='Enter email address' mod='kbmarketplace'}" value="">
                </div>
                <div class="kb-popup-btn-block">
                    <button type="submit" class="btn btn-danger submit-mp-personal-access" name="submitMPPersonalAccess" onclick="return submitKbMPAccessInfo()" value="1">{l s='Submit' mod='kbmarketplace'}</button>
                </div>
            </form>
        </div>
    </div>
{/if}
    <script type="text/javascript">
            var kb_empty_field = "{l s='Field cannot be empty.' mod='kbmarketplace'}";
            var kb_email_valid = "{l s='Email is not valid.' mod='kbmarketplace'}";
            var seller_front_url = "{$filter_form_action}";
            var kb_email_not_exit= "{l s='Email Address is not associated with any account.' mod='kbmarketplace'}";
        </script>
{*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer tohttp://www.prestashop.com for more information.
* We offer the best and most useful modules PrestaShop and modifications for your online store.
*
* @category  PrestaShop Module
* @author    knowband.com <support@knowband.com>
* @copyright 2016 knowband
* @license   see file: LICENSE.txt
*}