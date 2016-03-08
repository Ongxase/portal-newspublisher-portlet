
<%@include file="/init.jsp"%>

<ul class="news-abstract">

<%
	SearchContainer searchContainer = (SearchContainer)request.getAttribute("view.jsp-searchContainer");

	List<AssetEntry> results = (List<AssetEntry>)searchContainer.getResults();
	
	int total = searchContainer.getTotal();
	
	for (int assetEntryIndex = 0; assetEntryIndex < results.size(); assetEntryIndex++) {
		AssetEntry assetEntry = (AssetEntry)results.get(assetEntryIndex);
	
		long classPK = assetEntry.getClassPK();
		
		AssetRenderer assetRenderer = assetEntry.getAssetRenderer();
		
		if ((assetRenderer == null) || !assetRenderer.isDisplayable()) {
			continue;
		}
		
		String title = StringUtil.shorten(assetRenderer.getTitle(locale), titleLength);
		
		String summary = StringUtil.shorten(assetRenderer.getSummary(locale), summaryLength);
		
		String viewContentURL = NewsPublisherUtil.getViewContentURL(request, assetEntry, linkedLayout);
		
		String modifiedDate = dateFormat.format(assetEntry.getModifiedDate());
		
		String smallImagePath = NewsPublisherUtil.getSmallImagePath(request, classPK);
		
		if(Validator.isNull(smallImagePath) && useImageDefault){
			smallImagePath = assetRenderer.getThumbnailPath(renderRequest);
		}
		
		StringBuffer itemClass = new StringBuffer(StringPool.BLANK);
		
		if(assetEntryIndex % 2 == 0) {
			itemClass.append("even");
		} else {
			itemClass.append("odd");
		}
		
		if(assetEntryIndex == 0) {
			itemClass.append(" first");
		}else if(assetEntryIndex == (results.size() - 1)) {
			itemClass.append(" last");
		}
%>
	<li class="news-line <%=itemClass.toString() %>">
		<div class="news-title">
			<a href="<%=viewContentURL%>" title="<%= HtmlUtil.escape(title) %>"><%= HtmlUtil.escape(title) %></a>
		</div>
		
		<div class="news-content">
			<c:if test="<%= showSmallImage && Validator.isNotNull(smallImagePath) %>">
				<div class="news-simage">
					<a href="<%=viewContentURL %>" title="<%= HtmlUtil.escape(title) %>">
						<img src="<%= smallImagePath %>" alt="" />
					</a>
				</div>
			</c:if>
				
			<div class="news-summary" >
				<%= HtmlUtil.escape(summary) %>
			</div>
		</div>
	</li>
	<%
	}
%>

</ul>

<c:if test='<%= !paginationType.equals("none") && (total > results.size()) %>'>
	<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" type="<%= paginationType %>" />
</c:if>

<%!
	private static Log _log = LogFactoryUtil.getLog("html.display.abstract_jsp");
%>