{**
 * lib/pkp/templates/frontend/components/header.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2003-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Common frontend site header.
 *
 * @uses $isFullWidth bool Should this page be displayed without sidebars? This
 *       represents a page-level override, and doesn't indicate whether or not
 *       sidebars have been configured for thesite.
 *}
 {strip}
 {assign var="showingLogo" value=true}
 {if !$displayPageHeaderLogo}
	 {assign var="showingLogo" value=false}
 {/if}

 {capture assign="homeUrl"}
	 {url page="index" router=$smarty.const.ROUTE_PAGE}
 {/capture}
{/strip}

{capture assign="journalLogo"}
	{if $displayPageHeaderLogo}
		<img class="journal-logo" src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}"
		     {if $displayPageHeaderLogo.altText != ''}alt="{$displayPageHeaderLogo.altText|escape}"
		     {else}alt="{translate key="common.pageHeaderLogo.altText"}"{/if}>
	{elseif $displayPageHeaderTitle}
		<div class="journal-logo-text">{$displayPageHeaderTitle|escape}</div>
	{else}
		<img class="journal-logo" src="{$baseUrl}/templates/images/structure/logo.png" alt="{$applicationName|escape}">
	{/if}
{/capture}

<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
{if !$pageTitleTranslated}{capture assign="pageTitleTranslated"}{translate key="article.pageTitle" title=$article->getLocalizedTitle()|escape}{/capture}{/if}
{include file="frontend/components/headerHead.tpl"}
<body class="pkp_page_{$requestedPage|escape|default:"index"} pkp_op_{$requestedOp|escape|default:"index"}{if $showingLogo} has_site_logo{/if} htmlgalley" dir="{$currentLocaleLangDir|escape|default:"ltr"}">

	<div class="pkp_structure_page">

		{* Header *}
		<header>
			{* Skip to content nav links *}
			{include file="frontend/components/skipLinks.tpl"}

			<div class="header container-fluid">

				<div class="upper-header row">
					<h1 class="logo-wrapper col-md-7">
						<a href="{$homeUrl}" class="home-link">
							{$journalLogo}
						</a>
					</h1>
					<div id="user-nav-wraper" class="col-md-5">
						{* user navigation manu *}
						{load_menu name="user" id="navigationUser" ulClass="pkp_navigation_user"}
						{* language toggle block *}
						{include file="frontend/components/languageSwitcher.tpl" id="languageNav"}
					</div>
				</div>

				{capture assign="primaryMenu"}
					{load_menu name="primary" id="navigationPrimary" ulClass="pkp_navigation_primary"}
				{/capture}

				{* Show the primary menu only if it is set *}
				{if !empty(trim($primaryMenu)) || $currentContext}
					<div class="lower-header">
						<ul id="nav-small" class="nav nav-tabs">
							<li class="nav-item">
								<a id="show-modal" class="nav-link">
									<ion-icon name="menu"></ion-icon>
									<span class="ion-icon-text">{translate key="plugins.themes.classic.menu"}</span>
								</a>
							</li>
						</ul>
						{* modal div is added for menu adaptation for small screens *}
						<div id="modal-on-small" class="nav-modal hide">
							<div id="primary-nav-wraper">
									<span id="close-small-modal">
										<ion-icon name="close"></ion-icon>
									</span>
								{$primaryMenu}
							</div>
						</div>
					</div>
				{/if}
			</div>
		</header>

		{* Wrapper for page content and sidebars *}
		{if $isFullWidth}
			{assign var=hasSidebar value=0}
		{/if}
		<div class="pkp_structure_content{if $hasSidebar} has_sidebar{/if}">
			<div class="pkp_structure_main" role="main">
				<a id="pkp_content_main"></a>
