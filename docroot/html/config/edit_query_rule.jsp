<%@ include file="/init.jsp" %>

<%
long[] categorizableGroupIds = arrGroupIds;

request.setAttribute("configuration.jsp-categorizableScopeId", scopeGroupId);
%>

<div class="field-row form-inline query-row">
	<div class="query-condition">
		<aui:select inlineField="<%= true %>" label="" name="tagQueryContains">
			<aui:option label="contains" selected="<%= tagQueryContains %>" value="true" />
			<aui:option label="does-not-contain" selected="<%= !tagQueryContains %>" value="false" />
		</aui:select>
	
		<aui:select inlineField="<%= true %>" label="" name="tagQueryAndOperator">
			<aui:option label="all" selected="<%= tagQueryAndOperator %>" value="true" />
			<aui:option label="any" selected="<%= !tagQueryAndOperator %>" value="false" />
		</aui:select>
	
		<span class="query-label"><liferay-ui:message key="filter-by-tag"/></span	>
	</div>
	<div class="field tags-selector cnf-tags-selector">
		<liferay-ui:asset-tags-selector
			curTags='<%= tagNameValues %>'
			groupIds="<%= categorizableGroupIds %>"
			hiddenInput="queryTagNames"
		/>
	</div>

</div>

<div class="field-row form-inline query-row">
	<div class="query-condition">
		<aui:select inlineField="<%= true %>" label="" name="categoryQueryContains">
			<aui:option label="contains" selected="<%= categoryQueryContains %>" value="true" />
			<aui:option label="does-not-contain" selected="<%= !categoryQueryContains %>" value="false" />
		</aui:select>
	
		<aui:select inlineField="<%= true %>" label="" name="categoryQueryAndOperator">
			<aui:option label="all" selected="<%= categoryQueryAndOperator %>" value="true" />
			<aui:option label="any" selected="<%= !categoryQueryAndOperator %>" value="false" />
		</aui:select>
		<span class="query-label"><liferay-ui:message key="filter-by-category"/></span>
	</div>
	<div class="field categories-selector cfn-categories-selector">
		<liferay-ui:asset-categories-selector
			curCategoryIds='<%= categoryIdValues %>'
			hiddenInput="queryCategoryIds"
		/>
	</div>
</div>
