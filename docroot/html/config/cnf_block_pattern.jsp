<%@ include file="/init.jsp"%>
<%
	long[] categorizableGroupIds = arrGroupIds;//new long[]{scopeId};
	
	request.setAttribute("configuration.jsp-categorizableScopeId", scopeGroupId);

	int index = ParamUtil.getInteger(request, "index", 0);
	
	String blockTagNameValues = StringUtil.merge(portletPreferences.getValues("tagNameValues" + index, new String[0]));
	
	String blockCategoryIdValues = StringUtil.merge(portletPreferences.getValues("categoryIdValues" + index, new String[0]));
	
	String blockTitle = portletPreferences.getValue("blockTitle" + index, StringPool.BLANK);
	
	String blockTitleURL = portletPreferences.getValue("blockTitleURL" + index, StringPool.BLANK);
	
	String layoutUuidIndex = portletPreferences.getValue("layoutUuid" + index,
			StringPool.BLANK);
%>

<div class="block-preview">
	<div style="padding: 10px">
		<div class="remove-block" id="remove-block" index="<%=index%>">
			<span class="icon icon-remove">&nbsp</span>
		</div>
		<div class="block-title">
			<aui:input type="text" name='<%="blockTitle" + index%>' label="" value="<%=blockTitle %>" 
				placeholder="block-title" cssClass="block-title-input"/>
			
			<aui:select name='<%="layoutUuid" + index%>' label="link-to-page" id='<%="layoutUuid" + index%>'
			 showEmptyOption="<%=true %>">
				<%=NewsPublisherUtil.buildLayoutsToSelect(layoutUuidIndex, true, themeDisplay) %>
			</aui:select>
			
		</div>
			
		<strong><liferay-ui:message key="filter-by-tag"/></strong>
		<div class="field tags-selector">
			<liferay-ui:asset-tags-selector
				curTags='<%= blockTagNameValues %>'
				groupIds="<%= categorizableGroupIds %>"
				hiddenInput='<%="queryTagNames" + index %>'
			/>
		</div>
		<strong><liferay-ui:message key="filter-by-category"/></strong>	
		<div class="field categories-selector">
			<liferay-ui:asset-categories-selector
				curCategoryIds='<%= blockCategoryIdValues %>'
				hiddenInput='<%="queryCategoryIds" + index %>'
			/>
		</div>
	</div>
</div>