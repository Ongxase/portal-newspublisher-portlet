	
<%@include file="/init.jsp"%>

<%
AssetEntryQuery entryQueryTab = (AssetEntryQuery) request.getAttribute("block_tab.jsp-assetEntryQuery");

Layout blockRedirectLayout = (Layout) request.getAttribute("block_tab.jsp-blockRedirectLayout");

List<AssetEntry> results = NewsPublisherUtil.getAssetEntries(entryQueryTab);

int total = NewsPublisherUtil.getAssetEntriesCount(entryQueryTab);
%>
<div class="news-tab-content">
	<div class="news-box-inner">
		<%
		for(int assetEntryIndex = 0; assetEntryIndex < results.size(); assetEntryIndex++)
		{	
			AssetEntry assetEntry = results.get(assetEntryIndex);
			
			long classPK = assetEntry.getClassPK();
			
			AssetRenderer assetRenderer = assetEntry.getAssetRenderer();
			
			if ((assetRenderer == null) || !assetRenderer.isDisplayable()) {
				continue;
			}
			
			String title = StringUtil.shorten(assetRenderer.getTitle(locale), titleLength);
			
			String summary = StringUtil.shorten(assetRenderer.getSummary(locale), summaryLength);
			
			String viewContentURL = NewsPublisherUtil.getViewContentURL(request, assetEntry, blockRedirectLayout);
			
			String smallImagePath = NewsPublisherUtil.getSmallImagePath(request, classPK);
			
			if(Validator.isNull(smallImagePath) && useImageDefault){
				smallImagePath = assetRenderer.getThumbnailPath(renderRequest);
			}
		%>
			<c:choose>
				<c:when test="<%= assetEntryIndex == 0 %>">
					<div class="news-mt">
						<c:if test="<%= Validator.isNotNull(smallImagePath) %>">
							<a href="<%= viewContentURL %> " title="<%= HtmlUtil.escape(title) %>">
								<img src="<%= smallImagePath %>" alt=""/>
							</a>
						</c:if>
						
						<h3>
							<a href="<%=viewContentURL %>" title="<%= HtmlUtil.escape(title) %>">
								<%= HtmlUtil.escape(title) %>
							</a>
						</h3>
						
						<div class="news-summary" >
							<%= HtmlUtil.escape(summary) %>
						</div>
					</div>
				</c:when>
				
				<c:otherwise>
					<c:if test="<%= assetEntryIndex == 1 %>">
						<ul class="news-ul3">
					</c:if>
						<li>
							<a href="<%=viewContentURL %>" title="<%= HtmlUtil.escape(title) %>">
								<%= HtmlUtil.escape(title) %>
							</a>
						</li>
					<c:if test="<%= assetEntryIndex == results.size() - 1 %>">
						</ul>
					</c:if>
				</c:otherwise>
			</c:choose>
		<%
		}
		%>
	</div>
</div>

<%!
	private static Log _log = LogFactoryUtil.getLog("html.display.block_tab_item_jsp");
%>
