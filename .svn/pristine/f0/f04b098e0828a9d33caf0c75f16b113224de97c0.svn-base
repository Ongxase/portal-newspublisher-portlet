
<%@include file="/init.jsp"%>

<div class="news-bfn">

<%
	List<AssetEntry> results = (List<AssetEntry>) request.getAttribute("view.jsp-results");
	
	for (int assetEntryIndex = 0; assetEntryIndex < results.size(); assetEntryIndex++) {
		AssetEntry assetEntry = (AssetEntry)results.get(assetEntryIndex);
	
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
	<c:choose>
		<c:when test="<%= assetEntryIndex == 0 %>">
			<div class="news-mt <%=itemClass.toString() %>">
				
				<c:if test="<%= Validator.isNotNull(smallImagePath) %>">
					<a href="<%=viewContentURL%>" title="<%= HtmlUtil.escape(title) %>">
						<img src="<%= smallImagePath %>" alt=""/>
					</a>
				</c:if>
				
				<div class="news-content">
					<h3>
						<a href="<%=viewContentURL %>" title="<%= HtmlUtil.escape(title) %>">
							<%= HtmlUtil.escape(title) %>
						</a>
					</h3>
						
					<div class="news-summary" >
						<%= HtmlUtil.escape(summary) %>
					</div>
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

<%!
	private static Log _log = LogFactoryUtil.getLog("html_display_block_first_news_jsp");
%>