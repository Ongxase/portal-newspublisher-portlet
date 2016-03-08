
<%@ include file="/init.jsp" %>

<div class="news-wrapper clearfix <%= portletClass %>">

	<c:if test="<%=Validator.isNotNull(portletTitle) %>" >
		<h4 class="news-header-title">
			<c:choose>
				<c:when test="<%= Validator.isNotNull(linkedLayoutURL) %>">
					<a href="<%= linkedLayoutURL %>" title="<%= HtmlUtil.escape(portletTitle) %>"><%= HtmlUtil.escape(portletTitle) %></a>
				</c:when>
				<c:otherwise>
					<span><%= HtmlUtil.escape(portletTitle) %></span>
				</c:otherwise>
			</c:choose>
		</h4>
	</c:if>

	<%
		PortletURL portletURL = renderResponse.createRenderURL();
	
		SearchContainer<AssetEntry> searchContainer = 
			new SearchContainer<AssetEntry>(renderRequest, null, null, SearchContainer.DEFAULT_CUR_PARAM, displayItem, portletURL, null, null);
		
		if (!paginationType.equals("none")) {
			searchContainer.setDelta(displayItem);
			searchContainer.setDeltaConfigurable(false);
		}
		
		List<AssetEntry> results = NewsPublisherUtil.getAssetEntries(assetEntryQuery);
		
		int total = NewsPublisherUtil.getAssetEntriesCount(assetEntryQuery);
		
		searchContainer.setTotal(total);
		
		searchContainer.setResults(results);
		
		request.setAttribute("view.jsp-searchContainer", searchContainer);
		request.setAttribute("view.jsp-total", total);
		request.setAttribute("view.jsp-results", results);
	%>
	
	<liferay-util:include page='<%="/html/display/" + displayStyle + ".jsp" %>' servletContext="<%= application %>" />
</div>
