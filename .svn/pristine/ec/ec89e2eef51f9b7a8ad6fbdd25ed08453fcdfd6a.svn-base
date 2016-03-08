<%@ include file="/init.jsp" %>

<%
SearchContainer searchContainer = (SearchContainer)request.getAttribute("view.jsp-searchContainer");

List<AssetEntry> results = (List<AssetEntry>)searchContainer.getResults();
%>

<div class="news-fc-w">
	<c:if test="<%= results.size() > 0 %>">
		<div class="news-fc">
			<%
			AssetEntry focusAssetEntry = results.get(0);
			
			long focusClassPK = focusAssetEntry.getClassPK();
			
			AssetRendererFactory focusAssetRendererFactory = AssetRendererFactoryRegistryUtil.getAssetRendererFactoryByClassName(className);
			
			AssetRenderer focusAssetRenderer = null;
		
			try {
				focusAssetRenderer = focusAssetRendererFactory.getAssetRenderer(focusClassPK);
			}
			catch (Exception e) {
				if (_log.isWarnEnabled()) {
					_log.warn(e, e);
				}
			}
		
			%>
			
			<c:if test="<%= focusAssetRenderer != null && focusAssetRenderer.isDisplayable() %>">
				<%
				String title = StringUtil.shorten(focusAssetRenderer.getTitle(locale), titleLength);
				
				String description = StringUtil.shorten(focusAssetRenderer.getSummary(locale), summaryLength);
				
				String viewContentURL = NewsPublisherUtil.getViewContentURL(request, focusAssetEntry, linkedLayout);
				
				String smallImagePath = NewsPublisherUtil.getSmallImagePath(request, focusClassPK);
				
				if(Validator.isNull(smallImagePath) && useImageDefault){
					smallImagePath = focusAssetRenderer.getThumbnailPath(renderRequest);
				}
				%>
				
				<a href="<%=viewContentURL%>" title="<%= HtmlUtil.escape(title) %>">
					<img src="<%= smallImagePath %>" alt=""/>
				</a>
				
				<div class="news-fc-title" >
					<a href="<%=viewContentURL%>" title="<%= HtmlUtil.escape(title) %>">
						<%= HtmlUtil.escape(title) %>
					</a>
				</div>
				
				<div class="news-fc-description" >
					<a href="<%=viewContentURL%>" title="<%= HtmlUtil.escape(title) %>">
						<%= HtmlUtil.escape(description) %>
					</a>
				</div>
			</c:if>
		</div>
		
		<ul class="news-list-title">
			<%
			for(int index = 1; index < results.size(); index++)
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
				
				String title2 = StringUtil.shorten(assetRenderer.getTitle(locale), titleLength);
				
				String viewContentURL2 = NewsPublisherUtil.getViewContentURL(request, assetEntry, linkedLayout);
			%>
				<li>
					<a href="<%=viewContentURL2%>" title="<%= HtmlUtil.escape(title2) %>"><%= HtmlUtil.escape(title2) %></a>
				</li>
			<%
			}
			%>
		</ul>
	</c:if>
</div>
<%!
	private static Log _log = LogFactoryUtil.getLog("display_list_focus_jsp");
%>