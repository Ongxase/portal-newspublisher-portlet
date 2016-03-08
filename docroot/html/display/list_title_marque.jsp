	
<%@include file="/init.jsp"%>

<%
SearchContainer searchContainer = (SearchContainer)request.getAttribute("view.jsp-searchContainer");

List<AssetEntry> results = (List<AssetEntry>)searchContainer.getResults();
%>

<div class="news-marquee">
	<div class="news-marquee-wrapper" data-direction='up' data-duration='16000' data-pauseOnHover="true">
		<ul class="news-list-title">
			<%
			for(int index = 0; index < results.size(); index++)
			{	
				AssetEntry assetEntry = results.get(index);
				
				long classPK = assetEntry.getClassPK();
				
				AssetRendererFactory assetRendererFactory = AssetRendererFactoryRegistryUtil.getAssetRendererFactoryByClassName(className);
				
				if (assetRendererFactory == null) {
					continue;
				}
			
				AssetRenderer assetRenderer = null;
			
				try {
					assetRenderer = assetRendererFactory.getAssetRenderer(classPK);
				}
				catch (Exception e) {
					if (_log.isWarnEnabled()) {
						_log.warn(e, e);
					}
				}
			
				if ((assetRenderer == null) || !assetRenderer.isDisplayable()) {
					continue;
				}
				
				String title = StringUtil.shorten(assetRenderer.getTitle(locale), titleLength);
				
				String viewContentURL = NewsPublisherUtil.getViewContentURL(request, assetEntry, linkedLayout);
			%>
				<li>
					<a href="<%=viewContentURL%>" title="<%= HtmlUtil.escape(title) %>"><%= HtmlUtil.escape(title) %></a>
				</li>
			<%
			}
			%>
		</ul>
	</div>
</div>

<script type="text/javascript">
	jQuery('.news-marquee-wrapper').marquee();
</script>
<%!
	private static Log _log = LogFactoryUtil.getLog("html.display.list_title_marquee_jsp");
%>
