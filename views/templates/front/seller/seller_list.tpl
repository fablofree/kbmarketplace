<section id="main">
    <section id="products">
        <div class="products row">
            {foreach from=$sellers item=seller name=sellers}
            <div class="col-xs-6 col-md-3">
                <article class="product-miniature js-product-miniature">
                    <div class="thumbnail-container"  style = "Height : auto ; margin-bottom : 4px; ">
                        <a href="{$seller.href nofilter}" title="{$seller.title}" class="thumbnail product-thumbnail"> {* Variable contains HTML/CSS/JSON, escape not required *}

                           <img 
                              src = "{$seller.logo nofilter}"   {* Variable contains HTML/CSS/JSON, escape not required *}

                              alt = "{$seller.title}"
                            > 
                        </a>
    
                            <div class="product-description" style="height : auto;">
                                <h1 class="h3 product-title kb-tcenter"  style="font-weight: bold;"><a href="{$seller.href nofilter}" target='_blank' title="{$seller.title}"><strong>{$seller.title|truncate:30:'...'}</strong></a></h1>  {* Variable contains HTML/CSS/JSON, escape not required *}
                                <h2 class="h3 store_style kb-tcenter"  style="font-style: italic;"> Ville: {$seller.state} </h2>
                                
                                {*{if (!empty($seller.url_whatsapp)) }
                                    <a style="background:  {$seller.color|escape:'html':'UTF-8'}" class="whatsappchat-share" href="{$seller.url_whatsapp|escape:'html':'UTF-8'}" target="_blank">
                                        <i class="whatsapp-icon-3x" style="padding-right:0px!important;"></i>
                                    </a>
                                    <div class="wa-float wa-label-container wa-float-floating">
                                        <i class="icon icon-caret-left label-arrow" style="font-size: x-large;"></i>
                                         <div class="wa-label-text">Chat with {$seller.title}</div>
                                    </div>
                                {/if}*}
                        {*    <div class="product-price-and-shipping">
                                <div class="vss_seller_ratings">
                                    <div class="vss_rating_unfilled">★★★★★</div>
                                    <div class="vss_rating_filled" style="width:{$seller.rating_percent}%">★★★★★</div>
                                </div>
                            </div>
                            <div class="product-price-and-shipping">
                                <div class="kbmp-_row kb-tcenter">
                                <div class="kbmp-_inner_block"><a href="{$seller.view_review_href nofilter}" class="vss_active_link vss_read_review_bck" title='{l s='%s Review(s)'|sprintf:$seller.total_review mod='kbmarketplace'}'><span class="">{l s='View Reviews' mod='kbmarketplace'}</span></a></div> {* Variable contains HTML/CSS/JSON, escape not required *}
{*
                                    {if $seller.display_write_review}
                                        <div class="kbmp-_inner_block">
                                            {if !$kb_is_customer_logged}
                                                <a href="{$link->getPageLink('my-account', (bool)Configuration::get('PS_SSL_ENABLED')) nofilter}"  class="vss_active_link "><span class="">{l s='Write Review' mod='kbmarketplace'}</span></a>  {* Variable contains HTML/CSS/JSON, escape not required *}
{*
                                            {else}
                                                <a href="javascript:void(0)" class="vss_active_link vss_write_review_bck" data-toggle="kb-seller-new-review-popup" onclick="openSellerReviewPopup('kb-seller-new-review-popup', {$seller.id_seller|intval});"><span class="">{l s='Write Review' mod='kbmarketplace'}</span></a>
                                            {/if}
                                        </div>
                                    {/if}
                                </div>
                            </div> *}
                        </div>
                    </div>
                </article>
                </div>
            {/foreach}           
        </div>
    </section>
</section>
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