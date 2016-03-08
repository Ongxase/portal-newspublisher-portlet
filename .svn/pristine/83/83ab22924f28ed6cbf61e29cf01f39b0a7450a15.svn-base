	
<%@include file="/init.jsp"%>

<%
SearchContainer searchContainer = (SearchContainer)request.getAttribute("view.jsp-searchContainer");

List<AssetEntry> results = (List<AssetEntry>)searchContainer.getResults();
%>

<div class="news-list-title-wrapper">
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
	
	<c:if test="<%= showMore %>">
		<a class="icon-detail" title='<liferay-ui:message key="show-all"/>' href="<%= linkedLayoutURL %>">
			<liferay-ui:message key="show-all"/>
		</a>
	</c:if>
</div>
<%!
	private static Log _log = LogFactoryUtil.getLog("html.display.list_title_jsp");
%>
