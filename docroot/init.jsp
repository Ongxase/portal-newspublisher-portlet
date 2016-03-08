
<%@page import="com.liferay.portal.service.LayoutLocalServiceUtil"%>
<%@page import="com.liferay.portal.model.Layout"%>
<%@page import="com.liferay.portlet.journal.model.JournalArticle"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet"%>
<%@ taglib uri="http://liferay.com/tld/aui" prefix="aui"%>
<%@ taglib uri="http://liferay.com/tld/portlet" prefix="liferay-portlet"%>
<%@ taglib uri="http://liferay.com/tld/security" prefix="liferay-security"%>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme"%>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui"%>
<%@ taglib uri="http://liferay.com/tld/util" prefix="liferay-util"%>

<%@page import="javax.portlet.PortletURL"%>
<%@page import="java.util.Map"%>
<%@page	import="com.liferay.portlet.asset.service.persistence.AssetEntryQuery"%>
<%@page import="com.liferay.portal.kernel.util.ArrayUtil"%>
<%@page import="com.liferay.portal.model.LayoutRevision"%>
<%@page	import="com.liferay.portlet.asset.AssetRendererFactoryRegistryUtil"%>
<%@page import="com.liferay.portlet.PortletPreferencesFactoryUtil"%>
<%@page import="com.liferay.portal.kernel.util.GetterUtil"%>
<%@page import="com.liferay.portal.kernel.util.StringPool"%>
<%@page import="com.liferay.portal.kernel.util.Validator"%>
<%@page import="com.liferay.portal.kernel.util.ParamUtil"%>
<%@page import="com.liferay.portal.util.PortalUtil"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.liferay.portal.model.Group"%>
<%@page import="com.liferay.portlet.asset.model.AssetRendererFactory"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.liferay.portal.kernel.portlet.LiferayWindowState" %>
<%@page import="javax.portlet.PortletPreferences"%>
<%@page import="com.liferay.portal.kernel.util.PrefsParamUtil"%>
<%@page import="com.liferay.portal.kernel.util.StringUtil"%>
<%@page import="com.liferay.portal.kernel.util.Constants"%>
<%@page import="com.liferay.portal.kernel.util.PrefsParamUtil"%>
<%@page import="com.liferay.portal.kernel.util.StringUtil"%>
<%@page import="com.liferay.portal.kernel.util.KeyValuePairComparator"%>
<%@page import="com.liferay.portal.kernel.util.ListUtil"%>
<%@page import="com.liferay.portal.service.ClassNameLocalServiceUtil"%>
<%@page import="com.liferay.portal.model.ClassName"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.liferay.portal.kernel.language.LanguageUtil"%>
<%@page import="com.liferay.portal.security.permission.ResourceActionsUtil"%>
<%@page import="com.liferay.portal.kernel.util.Constants"%>
<%@page import="com.liferay.portlet.asset.model.AssetRenderer"%>
<%@page import="com.liferay.portlet.asset.model.AssetEntry"%>
<%@page import="com.liferay.portal.kernel.util.HtmlUtil"%>
<%@page import="com.liferay.portal.kernel.dao.search.SearchContainer"%>
<%@page import="com.liferay.portal.kernel.log.LogFactoryUtil"%>
<%@page import="com.liferay.portal.kernel.log.Log"%>
<%@page import="com.liferay.portlet.journal.service.JournalArticleResourceLocalServiceUtil"%>
<%@page import="com.liferay.portlet.journal.model.JournalArticleResource"%>
<%@page import="com.liferay.portal.service.GroupLocalServiceUtil"%>
<%@page import="com.liferay.portal.util.PortletKeys"%>

<%@page import="com.dtt.portal.newspublisher.util.NewsPublisherUtil"%>

<portlet:defineObjects />

<liferay-theme:defineObjects />

<%
	SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");

	String portletResource = ParamUtil.getString(request, "portletResource");

	if (Validator.isNotNull(portletResource)) {
		portletPreferences = PortletPreferencesFactoryUtil.getPortletSetup(
			request, portletResource);
	}

	long companyId = themeDisplay.getCompanyId();

	String portletId = PortalUtil.getPortletId(request);
	
	String currentURL = PortalUtil.getCurrentURL(liferayPortletRequest);

	/* Cau hinh loc */
	boolean tagQueryContains = GetterUtil.getBoolean(portletPreferences.getValue("tagQueryContains", null), true);

	boolean tagQueryAndOperator = GetterUtil.getBoolean(portletPreferences.getValue("tagQueryAndOperator", null), false);
	
	boolean categoryQueryContains = GetterUtil.getBoolean(portletPreferences.getValue("categoryQueryContains", null), true);

	boolean categoryQueryAndOperator = GetterUtil.getBoolean(portletPreferences.getValue("categoryQueryAndOperator", null), false);

	String tagNameValues = StringUtil.merge(portletPreferences.getValues("tagNameValues", new String[0]));
	
	String[] categoryIds = portletPreferences.getValues("categoryIdValues", new String[0]);
	
	String categoryIdValues = StringUtil.merge(categoryIds);
	
	/* Cau hinh hien thi  */
		
	String portletTitle = portletPreferences.getValue("portletTitle", StringPool.BLANK);
	
	String portletClass = portletPreferences.getValue("portletClass", StringPool.BLANK);
	
	String layoutUuid = portletPreferences.getValue("layoutUuid", StringPool.BLANK);
	
	String scopeIds = GetterUtil.getString(portletPreferences.getValue("scopeId", null), String.valueOf(scopeGroupId));
	
	long[] arrGroupIds = StringUtil.split(scopeIds, scopeGroupId);
	
	String displayStyle = portletPreferences.getValue("displayStyle", "list4");
	
	boolean showMore = GetterUtil.getBoolean(portletPreferences.getValue("showMore", null), false);
	
	//Hien thi anh mo ta hay khong?
	boolean showSmallImage = GetterUtil.getBoolean(portletPreferences.getValue("showSmallImage", null), true);
	
	boolean showSummary = GetterUtil.getBoolean(portletPreferences.getValue("showSummary", null), true);
	
	boolean useImageDefault = GetterUtil.getBoolean(portletPreferences.getValue("useImageDefault", null), true);
	
	//So luong hien thi tren 1 trang
	int displayItem = GetterUtil.getInteger(portletPreferences.getValue("displayItem", null), 5);
	
	//Kieu phan  trang
	String paginationType = GetterUtil.getString(portletPreferences.getValue("paginationType", "none"));
	
	//Do dai tieu de
	int titleLength = GetterUtil.getInteger(portletPreferences.getValue("titleLength", null), 100);
	
	//Do dai mieu ta ngan cua tin bai
	int summaryLength = GetterUtil.getInteger(portletPreferences.getValue("summaryLength", null), 200);
	
	/* Cau hinh sap xep  */
	
	String orderByColumn1 = portletPreferences.getValue("orderByColumn1", "publishDate");
	
	String orderByColumn2 = portletPreferences.getValue("orderByColumn2", "title");
	
	String orderByType1 = portletPreferences.getValue("orderByType1", "desc");
	
	String orderByType2 = portletPreferences.getValue("orderByType2", "asc");
	
	int blockNumber = GetterUtil.getInteger(portletPreferences.getValue("blockNumber", String.valueOf(0)));

	String blockIndex = portletPreferences.getValue("blockIndex", StringPool.BLANK);
		
	if(Validator.isNotNull(portletTitle)) {
		renderResponse.setTitle(portletTitle);
	}
	
	AssetEntryQuery assetEntryQuery = NewsPublisherUtil.getAssetEntryQuery(portletPreferences, arrGroupIds);
	
	String className = JournalArticle.class.getName();
	
	long classNameId = PortalUtil.getClassNameId(className);
	
	Layout linkedLayout = null;
	
	String linkedLayoutURL = StringPool.BLANK;
	
	if(Validator.isNotNull(layoutUuid)){
		linkedLayout = LayoutLocalServiceUtil.fetchLayoutByUuidAndGroupId(layoutUuid, themeDisplay.getScopeGroupId(), false);
	}
	
	if(linkedLayout != null){
		linkedLayoutURL = PortalUtil.getLayoutFullURL(linkedLayout, themeDisplay);
	}
	
	// @HUYMQ FIX RIENG CHO LONG BIEN: TIN CHI TIET NEU TRONG CAU HINH KHONG CO, SE TIM THEO CAU HINH "GIAO DIEN"
	// CON DANH SACH TIN VAN DE NGUYEN LAY CAU HINH TRONG PORTLET (linkedLayoutURL)
	
	if(linkedLayout == null) {
		String portletSetupLink = portletPreferences.getValue("portletSetupLinkToLayoutUuid", StringPool.BLANK);
		
		if(Validator.isNotNull(portletSetupLink)) {
			linkedLayout = LayoutLocalServiceUtil.fetchLayoutByUuidAndGroupId(portletSetupLink, themeDisplay.getScopeGroupId(), false);
		}
	}
	
	if(linkedLayout == null) {
		linkedLayout = themeDisplay.getLayout();
	}
%>