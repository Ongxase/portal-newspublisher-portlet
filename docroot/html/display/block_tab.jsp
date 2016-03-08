
<%@ include file="/init.jsp" %>

<%
	int[] indexBlocks = GetterUtil.getIntegerValues(StringUtil.split(blockIndex), new int[]{});

	StringBuilder tabNameValues = new StringBuilder();
	
	int indexTemp = 0;
	for(int indexBlock : indexBlocks) {
		String blockTitle = portletPreferences.getValue("blockTitle" + indexBlock, "block-news-" + indexBlock + 1);
		
		if(indexTemp > 0) {
			tabNameValues.append(",");
		}
		
		tabNameValues.append(StringUtil.replace(blockTitle, ",", "-"));
		indexTemp++;
	}
%>

<div class="news-bt">
	<liferay-ui:tabs names="<%= tabNameValues.toString() %>" refresh="false" tabsValues="<%= tabNameValues.toString() %>">
		<%
		for(int indexBlock : indexBlocks) {
			
			String[] tagNameValuesBlock = portletPreferences.getValues("tagNameValues" + indexBlock, new String[0]);
			
			String[] categoryIdValuesBlock = portletPreferences.getValues("categoryIdValues" +  indexBlock, new String[0]);
			
			boolean tagQueryContainsBlock = true;
			boolean tagQueryAndOperatorBlock = false;
			boolean categoryQueryContainsBlock = true;
			boolean categoryQueryAndOperatorBlock = false;
			
			NewsPublisherUtil.setAssetEntryQuery(assetEntryQuery, arrGroupIds, tagNameValuesBlock, 
					categoryIdValuesBlock, tagQueryContainsBlock, tagQueryAndOperatorBlock, categoryQueryContainsBlock, 
					categoryQueryAndOperatorBlock);
			
			request.setAttribute("block_tab.jsp-assetEntryQuery", assetEntryQuery);
			
			String layoutUuidIndex = portletPreferences.getValue("layoutUuid" + indexBlock, StringPool.BLANK);
			
			String blockLinkedLayoutURL = StringPool.BLANK;
			Layout blockRedirectLayout = null;
			
			if(Validator.isNotNull(layoutUuidIndex)){
				blockRedirectLayout = LayoutLocalServiceUtil.fetchLayoutByUuidAndGroupId(layoutUuidIndex, themeDisplay.getScopeGroupId(), false);
				
				if(blockRedirectLayout != null){
					blockLinkedLayoutURL = blockRedirectLayout.getFriendlyURL();
				}
			}
			
			request.setAttribute("block_tab.jsp-blockRedirectLayout", blockRedirectLayout);
		%>
		
		<liferay-ui:section>
			<liferay-util:include page='<%="/html/display/" + displayStyle + "_item.jsp" %>' servletContext="<%= application %>" />
			
			<c:if test="<%= showMore %>">
				<a class="icon-detail" title='<liferay-ui:message key="show-all"/>' href="<%= blockLinkedLayoutURL %>">
					<liferay-ui:message key="show-all"/>
				</a>
			</c:if>
		</liferay-ui:section>
		<%	
		}
		%>
	</liferay-ui:tabs>
</div>

<aui:script>
AUI().use('event', 'node', function(A) {
	A.all('.news-bt ul.nav-tabs').each(function(node) {
		node.delegate('click', function(event){
			var id = event.currentTarget.getAttribute("id");
			
			if(id) {
				var a = A.one("#" + id.replace("TabsId", "") + "TabsSection a.icon-detail");
				
				if(a) {
					location.href = a.getAttribute("href");
				}
			}
			
		}, 'li.active');
	})
});
</aui:script>