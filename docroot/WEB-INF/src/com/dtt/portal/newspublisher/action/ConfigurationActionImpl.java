package com.dtt.portal.newspublisher.action;

import java.util.ArrayList;
import java.util.List;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;
import javax.portlet.PortletPreferences;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.liferay.portal.kernel.portlet.DefaultConfigurationAction;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.util.Constants;
import com.liferay.portal.kernel.util.GetterUtil;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.StringPool;
import com.liferay.portal.kernel.util.StringUtil;
import com.liferay.portal.kernel.util.WebKeys;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.portlet.PortletPreferencesFactoryUtil;
import com.liferay.portlet.asset.service.AssetTagLocalServiceUtil;

/**
 * @author TrungNT
 */

public class ConfigurationActionImpl extends DefaultConfigurationAction
{
	@Override
	public void processAction(PortletConfig portletConfig, ActionRequest actionRequest, ActionResponse actionResponse)
		throws Exception{
	
		try{
		
			String cmd = ParamUtil.getString(actionRequest, Constants.CMD);
			
			boolean addNewsBlock = GetterUtil.getBoolean(ParamUtil.getString(actionRequest, "addNewsBlock"), false);

			String portletResource = ParamUtil.getString(actionRequest, "portletResource");

			PortletPreferences preferences = PortletPreferencesFactoryUtil.getPortletSetup(actionRequest, portletResource);

			if (cmd.equals(Constants.UPDATE)){
				
				if(addNewsBlock){
					updateBlockNumber(actionRequest, preferences);
				}else{
					updateQueryLogic(actionRequest, preferences);
					updateBlockNumber(actionRequest, preferences);
					updateBlockQueryLogic(actionRequest, preferences);
				}

				preferences.store();
				
				super.processAction(portletConfig, actionRequest, actionResponse);
				
			}
		}catch (Exception e){
			_log.error(e);
			
			SessionErrors.add(actionRequest, e.getClass().getName(), e);
		}
	}

	@Override
	public String render(PortletConfig portletConfig, RenderRequest renderRequest, RenderResponse renderResponse)
		throws Exception{
		return "/html/configuration.jsp";
	}

	/**
	 * @todo CAP NHAT CAU HINH LOC TIN
	 * @author TrungNT
	 * @date Nov 17, 2014
	 * @return void
	 * @param actionRequest
	 * @param preferences
	 */
	protected void updateQueryLogic(ActionRequest actionRequest, PortletPreferences preferences)
		throws Exception{
	
		ThemeDisplay themeDisplay = (ThemeDisplay) actionRequest.getAttribute(WebKeys.THEME_DISPLAY);

		long userId = themeDisplay.getUserId();
		long groupId = themeDisplay.getScopeGroupId();

		boolean tagQueryContains = ParamUtil.getBoolean(actionRequest, "tagQueryContains");
		boolean tagQueryAndOperator = ParamUtil.getBoolean(actionRequest, "tagQueryAndOperator");
		
		boolean categoryQueryContains = ParamUtil.getBoolean(actionRequest, "categoryQueryContains");
		boolean categoryQueryAndOperator = ParamUtil.getBoolean(actionRequest, "categoryQueryAndOperator");
		
		String[] tagNameValues = null;
		String[] categoryIdValues = null;
		
		tagNameValues = StringUtil.split(ParamUtil.getString(actionRequest, "queryTagNames"));

		AssetTagLocalServiceUtil.checkTags(userId, groupId, tagNameValues);
		
		categoryIdValues = StringUtil.split(ParamUtil.getString(actionRequest, "queryCategoryIds"));
		
		setPreference(actionRequest, "tagQueryContains", String.valueOf(tagQueryContains));
		setPreference(actionRequest, "tagQueryAndOperator", String.valueOf(tagQueryAndOperator));
		setPreference(actionRequest, "tagNameValues", tagNameValues);
		
		setPreference(actionRequest, "categoryQueryContains", String.valueOf(categoryQueryContains));
		setPreference(actionRequest, "categoryQueryAndOperator", String.valueOf(categoryQueryAndOperator));
		setPreference(actionRequest, "categoryIdValues", categoryIdValues);
		
	}
	
	/**
	 * @todo CAP NHAT CAU HINH LOC TIN
	 * @author TrungNT
	 * @date Nov 17, 2014
	 * @return void
	 * @param actionRequest
	 * @param preferences
	 */
	protected void updateBlockQueryLogic(ActionRequest actionRequest, PortletPreferences preferences)
		throws Exception{
		
		String blockIndex = ParamUtil.get(actionRequest, "blockIndex", String.valueOf(0));
		String[] arrIndex = StringUtil.split(blockIndex);
		
		if(arrIndex != null){
			
			ThemeDisplay themeDisplay = (ThemeDisplay) actionRequest.getAttribute(WebKeys.THEME_DISPLAY);

			long userId = themeDisplay.getUserId();
			long groupId = themeDisplay.getScopeGroupId();
			
			for(int i = 0; i < arrIndex.length; i++){
				String blockTitle = StringPool.BLANK;
				String blockTitleURL = StringPool.BLANK;
				String[] tagNameValues = null;
				String[] categoryIdValues = null;
				String layoutUuid = StringPool.BLANK;
				
				tagNameValues = StringUtil.split(ParamUtil.getString(actionRequest, "queryTagNames" + arrIndex[i]));

				AssetTagLocalServiceUtil.checkTags(userId, groupId, tagNameValues);
				
				categoryIdValues = StringUtil.split(ParamUtil.getString(actionRequest, "queryCategoryIds" + arrIndex[i]));
				
				blockTitle = ParamUtil.getString(actionRequest, "blockTitle" + arrIndex[i]);
				
				blockTitleURL = ParamUtil.getString(actionRequest, "blockTitleURL" + arrIndex[i]);
				
				layoutUuid = ParamUtil.getString(actionRequest, "layoutUuid" + arrIndex[i]);
				
				setPreference(actionRequest, "blockTitle" + arrIndex[i], blockTitle);
				
				setPreference(actionRequest, "blockTitleURL" + arrIndex[i], blockTitleURL);
				
				setPreference(actionRequest, "tagNameValues" + arrIndex[i], tagNameValues);
				
				setPreference(actionRequest, "categoryIdValues" + arrIndex[i], categoryIdValues);
				
				setPreference(actionRequest, "layoutUuid" + arrIndex[i], layoutUuid);
			}

		}

	}
	
	/**
	 * @todo CAP NHAT CAU HINH LOC TIN
	 * @author TrungNT
	 * @date Nov 17, 2014
	 * @return void
	 * @param actionRequest
	 * @param preferences
	 */
	protected void updateBlockNumber(ActionRequest actionRequest, PortletPreferences preferences)
		throws Exception{
		int blockNumber = GetterUtil.getInteger(ParamUtil.get(actionRequest, "blockNumber", String.valueOf(0)));
		
		String displayStyle =  ParamUtil.get(actionRequest, "displayStyle", String.valueOf(0));
				
		if(blockNumber < 0){
			blockNumber = 0;
		}
		String blockIndex = ParamUtil.get(actionRequest, "blockIndex", String.valueOf(0));
		String[] arrIndexTemp = StringUtil.split(blockIndex);
		List<String> indexs = new ArrayList<String>();
		if(arrIndexTemp != null){
			if(arrIndexTemp.length == 0){
				blockNumber = 0;
			}
			for(int i = 0; i < arrIndexTemp.length; i++){
				int temp = 0;
				try {
					temp = Integer.parseInt(arrIndexTemp[i]);
				} catch (Exception e) {
					continue;
				}
				indexs.add(String.valueOf(temp));
				if(temp > blockNumber){
					blockNumber = temp;
				}
			}
		}
		
		blockIndex = StringUtil.merge(indexs.toArray());
		setPreference(actionRequest, "displayStyle", displayStyle);
		setPreference(actionRequest, "blockNumber", String.valueOf(blockNumber));
		setPreference(actionRequest, "blockIndex", blockIndex);
	}

	private static Log _log = LogFactory.getLog(ConfigurationActionImpl.class.getName());
}

