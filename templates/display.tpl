{**
 * plugins/generic/embedHtmlArticleGalley/display.tpl
 *
 * Copyright (c) 2014-2019 Simon Fraser University
 * Copyright (c) 2003-2019 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Embedded viewing of a HTML galley.
 *}
{include file=$headerTemplatePath}
{include file=$breadcrumbsTemplatePath}
		<div id="htmlContainer" class="container-fluid container-page">
			{if !$isLatestPublication}
				<div class="galley_view_notice">
					<div class="galley_view_notice_message" role="alert">
						{translate key="submission.outdatedVersion" datePublished=$galleyPublication->getData('datePublished')|date_format:$dateFormatLong urlRecentVersion=$articleUrl}
					</div>
				 </div>
			{/if}
			{$html}

			{* UZH CHANGE OJS-67 2019/03/08/mb display Licensing info *}
			{* Licensing info *}
			{if $copyright || $licenseUrl}
				<div class="item copyright">
					{if $licenseUrl}
						{if $ccLicenseBadge}
							{if $copyrightHolder}
								<p>{translate key="submission.copyrightStatement" copyrightHolder=$copyrightHolder copyrightYear=$copyrightYear}</p>
							{/if}
							{$ccLicenseBadge}
						{else}
							<a href="{$licenseUrl|escape}" class="copyright">
								{if $copyrightHolder}
									{translate key="submission.copyrightStatement" copyrightHolder=$copyrightHolder copyrightYear=$copyrightYear}
								{else}
									{translate key="submission.license"}
								{/if}
							</a>
						{/if}
					{/if}
				</div>
			{/if}
        		{* END UZH CHANGE OJS-67 *}
		</div>

	{call_hook name="Templates::Common::Footer::PageFooter"}
	{include file=$footerTemplatePath}
</body>
</html>
