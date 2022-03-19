script "UIWindowAnimateResize"
// converted from stackoverflow.com/questions/1769317/animate-window-resize-width-and-height-c-sharp-wpf


local mNewWidth
local mNewHeight
local mWinID
local mWinLeft
local mWinTop
local mAnimateResizeStop
local mAnimateResizeRatioHeight
local mAnimateResizeRatioWidth
local mAnimateResizeMessageID


on UIWindowAnimateResize winID, newWidth, newHeight
   if (word 1 of winID = "stack") then
      put winID into mWinID
      put the left of winID into mWinLeft
      put the top of winID into mWinTop
      put newWidth into mNewWidth
      put newHeight into mNewHeight
      send "UIWindowAnimateResizeTick" to me in 20 milliseconds
      put the result into mAnimateResizeMessageID
   end if
end UIWindowAnimateResize


on UIWindowAnimateResizeCancel
   cancel mAnimateResizeMessageID
end UIWindowAnimateResizeCancel


on UIWindowAnimateResizeTick
   if (mAnimateResizeStop = 0) then
      put (((the height of mWinID - mNewHeight) / 12) * -1) into mAnimateResizeRatioHeight
      put (((the width of mWinID - mNewWidth) / 12) * -1) into mAnimateResizeRatioWidth
   end if
   add 1 to mAnimateResizeStop
   
   lock screen
   set the height of mWinID to (the height of mWinID + mAnimateResizeRatioHeight)
   set the width of mWinID to (the width of mWinID + mAnimateResizeRatioWidth)
   set the topLeft of mWinID to mWinLeft, mWinTop
   unlock screen
   
   send "UIWindowAnimateResizeTick" to me in 20 milliseconds
   put the result into mAnimateResizeMessageID
   
   if (mAnimateResizeStop = 12) then
      cancel mAnimateResizeMessageID
      lock screen
      set the height of mWinID to mNewHeight
      set the width of mWinID to mNewWidth
      set the topLeft of mWinID to mWinLeft, mWinTop
      unlock screen
      
      put 0 into mAnimateResizeStop
      put 0 into mAnimateResizeRatioHeight
      put 0 into mAnimateResizeRatioWidth
      put 0 into mNewHeight
      put 0 into mNewWidth
      put 0 into mWinID
      put 0 into mWinLeft
      put 0 into mWinTop
   end if
end UIWindowAnimateResizeTick
