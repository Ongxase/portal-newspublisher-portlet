
package com.dtt.portal.newspublisher.util;

import com.liferay.portal.kernel.util.GetterUtil;
import com.liferay.portal.kernel.util.PropsUtil;
import com.liferay.util.portlet.PortletProps;

/**
 * @author HuyMQ
 */
public class PortletPropsValues
{
	public static final int[] ARTICLE_SUMMARY_ABSTRACT_LENGTH =
		GetterUtil.getIntegerValues(PortletProps.getArray(
			PortletPropsKeys.ARTICLE_SUMMARY_ABSTRACT_LENGTH));
	
	public static final int[] ARTICLE_SUMMARY_DELTA = GetterUtil.getIntegerValues(
		PortletProps.getArray(PortletPropsKeys.ARTICLE_SUMMARY_DELTA));
	
	public static final boolean ASSET_PUBLISHER_INSTANCE = GetterUtil.getBoolean(
		PropsUtil.get(PortletPropsKeys.ASSET_PUBLISHER_INSTANCE), false);
}
