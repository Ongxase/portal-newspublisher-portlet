
<%@include file="/init.jsp"%>

<div class="slider_wrapper">
	<div id="<portlet:namespace/>slider1_container" style="position: relative; top:10px; width: 480px; height: 485px; overflow: hidden;">
		<!-- Slides Container -->
		<div u="slides" class="news_slider_slides" style="position: absolute; left: 0px; top: 0px; width: 480px; height: 320px; overflow: hidden;">
			
			<%
				SearchContainer searchContainer = (SearchContainer)request.getAttribute("view.jsp-searchContainer");
			
				List<AssetEntry> results = (List<AssetEntry>)searchContainer.getResults();
				
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
					
					String title = assetRenderer.getTitle(locale);
					
					String viewContentURL = NewsPublisherUtil.getViewContentURL(request, assetEntry, linkedLayout);
					
					String smallImagePath = NewsPublisherUtil.getSmallImagePath(request, classPK);
					
					if(Validator.isNull(smallImagePath)){
						smallImagePath = assetRenderer.getThumbnailPath(renderRequest);
					}
			%>
				<div>
					<a href="<%=viewContentURL %>" title="<%= HtmlUtil.escape(title) %>">
						<img u="image" src="<%= smallImagePath %>" class="classImgIndex<%= assetEntryIndex%>"/>
							
						<div class="shadow">
							<p><%= HtmlUtil.escape(title) %></p>
						</div>
						
						<img u="thumb" src="<%= smallImagePath %>" alt=""/>
					</a>
				</div>
				<%
				}
			%>
		</div>
		
		<!-- thumbnail navigator container -->
		<div u="thumbnavigator" class="jssort01" style="left: 0px; bottom: 0px;">
			<!-- Thumbnail Item Skin Begin -->
			<div u="slides">
				<div u="prototype" class="p">
					<div class=w><div u="thumbnailtemplate" class="t"></div></div>
					<div class=c></div>
				</div>
			</div>
			
			<%
			int assetEntryIndex = 0;
			for (; assetEntryIndex < results.size(); assetEntryIndex++) {
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
				
				String viewContentURL = NewsPublisherUtil.getViewContentURL(request, assetEntry, linkedLayout);
			%>
				<div class="pos pos-<%= assetEntryIndex %>">
					<a href="<%=viewContentURL %>" title="<%= HtmlUtil.escape(title) %>">
						<%= HtmlUtil.escape(title) %>
					</a>
				</div>
			<% } %>
			<!-- Thumbnail Item Skin End -->
		</div>
		<!--#endregion Thumbnail Navigator Skin End -->
	</div>
</div>

<aui:script>
jQuery(document).ready(function ($) {

    var _SlideshowTransitions = [
    //Fade in L
        {$Duration: 1200, x: 0.3, $During: { $Left: [0.3, 0.7] }, $Easing: { $Left: $JssorEasing$.$EaseInCubic, $Opacity: $JssorEasing$.$EaseLinear }, $Opacity: 2 }
    //Fade out R
        , { $Duration: 1200, x: -0.3, $SlideOut: true, $Easing: { $Left: $JssorEasing$.$EaseInCubic, $Opacity: $JssorEasing$.$EaseLinear }, $Opacity: 2 }
    //Fade in R
        , { $Duration: 1200, x: -0.3, $During: { $Left: [0.3, 0.7] }, $Easing: { $Left: $JssorEasing$.$EaseInCubic, $Opacity: $JssorEasing$.$EaseLinear }, $Opacity: 2 }
    //Fade out L
        , { $Duration: 1200, x: 0.3, $SlideOut: true, $Easing: { $Left: $JssorEasing$.$EaseInCubic, $Opacity: $JssorEasing$.$EaseLinear }, $Opacity: 2 }

    //Fade in T
        , { $Duration: 1200, y: 0.3, $During: { $Top: [0.3, 0.7] }, $Easing: { $Top: $JssorEasing$.$EaseInCubic, $Opacity: $JssorEasing$.$EaseLinear }, $Opacity: 2, $Outside: true }
    //Fade out B
        , { $Duration: 1200, y: -0.3, $SlideOut: true, $Easing: { $Top: $JssorEasing$.$EaseInCubic, $Opacity: $JssorEasing$.$EaseLinear }, $Opacity: 2, $Outside: true }
    //Fade in B
        , { $Duration: 1200, y: -0.3, $During: { $Top: [0.3, 0.7] }, $Easing: { $Top: $JssorEasing$.$EaseInCubic, $Opacity: $JssorEasing$.$EaseLinear }, $Opacity: 2 }
    //Fade out T
        , { $Duration: 1200, y: 0.3, $SlideOut: true, $Easing: { $Top: $JssorEasing$.$EaseInCubic, $Opacity: $JssorEasing$.$EaseLinear }, $Opacity: 2 }

    //Fade Clip in H
        , { $Duration: 1200, $Delay: 20, $Clip: 3, $Assembly: 260, $Easing: { $Clip: $JssorEasing$.$EaseInCubic, $Opacity: $JssorEasing$.$EaseLinear }, $Opacity: 2 }
    //Fade Clip out H
        , { $Duration: 1200, $Delay: 20, $Clip: 3, $SlideOut: true, $Assembly: 260, $Easing: { $Clip: $JssorEasing$.$EaseOutCubic, $Opacity: $JssorEasing$.$EaseLinear }, $Opacity: 2 }
    //Fade Clip in V
        , { $Duration: 1200, $Delay: 20, $Clip: 12, $Assembly: 260, $Easing: { $Clip: $JssorEasing$.$EaseInCubic, $Opacity: $JssorEasing$.$EaseLinear }, $Opacity: 2 }
    //Fade Clip out V
        , { $Duration: 1200, $Delay: 20, $Clip: 12, $SlideOut: true, $Assembly: 260, $Easing: { $Clip: $JssorEasing$.$EaseOutCubic, $Opacity: $JssorEasing$.$EaseLinear }, $Opacity: 2 }
        ];

    var options = {
        $AutoPlay: true,                                    //[Optional] Whether to auto play, to enable slideshow, this option must be set to true, default value is false
        $AutoPlayInterval: 5000,                            //[Optional] Interval (in milliseconds) to go for next slide since the previous stopped if the slider is auto playing, default value is 3000
        $PauseOnHover: 1,                                //[Optional] Whether to pause when mouse over if a slider is auto playing, 0 no pause, 1 pause for desktop, 2 pause for touch device, 3 pause for desktop and touch device, 4 freeze for desktop, 8 freeze for touch device, 12 freeze for desktop and touch device, default value is 1

        $DragOrientation: 0,                                //[Optional] Orientation to drag slide, 0 no drag, 1 horizental, 2 vertical, 3 either, default value is 1 (Note that the $DragOrientation should be the same as $PlayOrientation when $DisplayPieces is greater than 1, or parking position is not 0)
        $ArrowKeyNavigation: false,   			            //[Optional] Allows keyboard (arrow key) navigation or not, default value is false
        $SlideDuration: 800,                                //Specifies default duration (swipe) for slide in milliseconds

        $SlideshowOptions: {                                //[Optional] Options to specify and enable slideshow or not
            $Class: $JssorSlideshowRunner$,                 //[Required] Class to create instance of slideshow
            $Transitions: _SlideshowTransitions,            //[Required] An array of slideshow transitions to play slideshow
            $TransitionsOrder: 1,                           //[Optional] The way to choose transition to play slide, 1 Sequence, 0 Random
            $ShowLink: true                                    //[Optional] Whether to bring slide link on top of the slider when slideshow is running, default value is false
        },

        $ArrowNavigatorOptions: {                       //[Optional] Options to specify and enable arrow navigator or not
            $Class: $JssorArrowNavigator$,              //[Requried] Class to create arrow navigator instance
            $ChanceToShow: 1                               //[Required] 0 Never, 1 Mouse Over, 2 Always
        },

        $ThumbnailNavigatorOptions: {                       //[Optional] Options to specify and enable thumbnail navigator or not
            $Class: $JssorThumbnailNavigator$,              //[Required] Class to create thumbnail navigator instance
            $ChanceToShow: 2,                               //[Required] 0 Never, 1 Mouse Over, 2 Always

            $DragOrientation: 0,

            $ActionMode: 1,                                 //[Optional] 0 None, 1 act by click, 2 act by mouse hover, 3 both, default value is 1
            $SpacingX: 10,                                  //[Optional] Horizontal space between each thumbnail in pixel, default value is 0
            $DisplayPieces: 3,                              //[Optional] Number of pieces to display, default value is 1
            $ParkingPosition: 0                             //[Optional] The offset position to park thumbnail
        }
    };

    var jssor_slider1 = new $JssorSlider$("<portlet:namespace/>slider1_container", options);
});
</aui:script>
<%!
	private static Log _log = LogFactoryUtil.getLog("html_display_slider_horizontal.jsp");
%>