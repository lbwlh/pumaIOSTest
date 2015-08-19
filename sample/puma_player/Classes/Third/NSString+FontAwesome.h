//
//  NSString+FontAwesome.h
//
//  Created by Pit Garbe on 27.09.12.
//  Copyright (c) 2012 Pit Garbe. All rights reserved.
//
//  https://github.com/leberwurstsaft/FontAwesome-for-iOS
//
//
//  * The Font Awesome font is licensed under the SIL Open Font License
//  http://scripts.sil.org/OFL
//
//
// * Font Awesome CSS, LESS, and SASS files are licensed under the MIT License
//  http://opensource.org/licenses/mit-license.html
//
//
//  * The Font Awesome pictograms are licensed under the CC BY 3.0 License
//  http://creativecommons.org/licenses/by/3.0
//
//
//  * Attribution is no longer required in Font Awesome 3.0, but much appreciated:
//  "Font Awesome by Dave Gandy - http://fortawesome.github.com/Font-Awesome"
//
//
//  -----------------------------------------
//  Edited and refactored by Jesse Squires on 2 April, 2013.
//
//  http://github.com/jessesquires/BButton
//
//  http://hexedbits.com
//

@import Foundation;

typedef enum {
    FAIconGlass = 0,
    FAIconMusic,
    FAIconSearch,
    FAIconEnvelope,
    FAIconHeart,
    FAIconStar,
    FAIconStarEmpty,
    FAIconUser,
    FAIconFilm,
    FAIconThLarge,
    FAIconTh,
    FAIconThList,
    FAIconOk,
    FAIconRemove,
    FAIconZoomIn,
    FAIconZoomOut,
    FAIconOff,
    FAIconSignal,
    FAIconCog,
    FAIconTrash,
    FAIconHome,
    FAIconFile,
    FAIconTime,
    FAIconRoad,
    FAIconDownloadAlt,
    FAIconDownload,
    FAIconUpload,
    FAIconInbox,
    FAIconPlayCircle,
    FAIconRepeat,
    FAIconRefresh,
    FAIconListAlt,
    FAIconLock,
    FAIconFlag,
    FAIconHeadphones,
    FAIconVolumeOff,
    FAIconVolumeDown,
    FAIconVolumeUp,
    FAIconQrcode,
    FAIconBarcode,
    FAIconTag,
    FAIconTags,
    FAIconBook,
    FAIconBookmark,
    FAIconPrint,
    FAIconCamera,
    FAIconFont,
    FAIconBold,
    FAIconItalic,
    FAIconTextHeight,
    FAIconTextWidth,
    FAIconAlignLeft,
    FAIconAlignCenter,
    FAIconAlignRight,
    FAIconAlignJustify,
    FAIconList,
    FAIconIndentLeft,
    FAIconIndentRight,
    FAIconFacetimeVideo,
    FAIconPicture,
    FAIconPencil,
    FAIconMapMarker,
    FAIconAdjust,
    FAIconTint,
    FAIconEdit,
    FAIconShare,
    FAIconCheck,
    FAIconMove,
    FAIconStepBackward,
    FAIconFastBackward,
    FAIconBackward,
    FAIconPlay,
    FAIconPause,
    FAIconStop,
    FAIconForward,
    FAIconFastForward,
    FAIconStepForward,
    FAIconEject,
    FAIconChevronLeft,
    FAIconChevronRight,
    FAIconPlusSign,
    FAIconMinusSign,
    FAIconRemoveSign,
    FAIconOkSign,
    FAIconQuestionSign,
    FAIconInfoSign,
    FAIconScreenshot,
    FAIconRemoveCircle,
    FAIconOkCircle,
    FAIconBanCircle,
    FAIconArrowLeft,
    FAIconArrowRight,
    FAIconArrowUp,
    FAIconArrowDown,
    FAIconShareAlt,
    FAIconResizeFull,
    FAIconResizeSmall,
    FAIconPlus,
    FAIconMinus,
    FAIconAsterisk,
    FAIconExclamationSign,
    FAIconGift,
    FAIconLeaf,
    FAIconFire,
    FAIconEyeOpen,
    FAIconEyeClose,
    FAIconWarningSign,
    FAIconPlane,
    FAIconCalendar,
    FAIconRandom,
    FAIconComment,
    FAIconMagnet,
    FAIconChevronUp,
    FAIconChevronDown,
    FAIconRetweet,
    FAIconShoppingCart,
    FAIconFolderClose,
    FAIconFolderOpen,
    FAIconResizeVertical,
    FAIconResizeHorizontal,
    FAIconBarChart,
    FAIconTwitterSign,
    FAIconFacebookSign,
    FAIconCameraRetro,
    FAIconKey,
    FAIconCogs,
    FAIconComments,
    FAIconThumbsUp,
    FAIconThumbsDown,
    FAIconStarHalf,
    FAIconHeartEmpty,
    FAIconSignout,
    FAIconLinkedinSign,
    FAIconPushpin,
    FAIconExternalLink,
    FAIconSignin,
    FAIconTrophy,
    FAIconGithubSign,
    FAIconUploadAlt,
    FAIconLemon,
    FAIconPhone,
    FAIconCheckEmpty,
    FAIconBookmarkEmpty,
    FAIconPhoneSign,
    FAIconTwitter,
    FAIconFacebook,
    FAIconGithub,
    FAIconUnlock,
    FAIconCreditCard,
    FAIconRss,
    FAIconHdd,
    FAIconBullhorn,
    FAIconBell,
    FAIconCertificate,
    FAIconHandRight,
    FAIconHandLeft,
    FAIconHandUp,
    FAIconHandDown,
    FAIconCircleArrowLeft,
    FAIconCircleArrowRight,
    FAIconCircleArrowUp,
    FAIconCircleArrowDown,
    FAIconGlobe,
    FAIconWrench,
    FAIconTasks,
    FAIconFilter,
    FAIconBriefcase,
    FAIconFullscreen,
    FAIconGroup,
    FAIconLink,
    FAIconCloud,
    FAIconBeaker,
    FAIconCut,
    FAIconCopy,
    FAIconPaperClip,
    FAIconSave,
    FAIconSignBlank,
    FAIconReorder,
    FAIconListUl,
    FAIconListOl,
    FAIconStrikethrough,
    FAIconUnderline,
    FAIconTable,
    FAIconMagic,
    FAIconTruck,
    FAIconPinterest,
    FAIconPinterestSign,
    FAIconGooglePlusSign,
    FAIconGooglePlus,
    FAIconMoney,
    FAIconCaretDown,
    FAIconCaretUp,
    FAIconCaretLeft,
    FAIconCaretRight,
    FAIconColumns,
    FAIconSort,
    FAIconSortDown,
    FAIconSortUp,
    FAIconEnvelopeAlt,
    FAIconLinkedin,
    FAIconUndo,
    FAIconLegal,
    FAIconDashboard,
    FAIconCommentAlt,
    FAIconCommentsAlt,
    FAIconBolt,
    FAIconSitemap,
    FAIconUmbrella,
    FAIconPaste,
    FAIconUserMd
} FAIcon;


@interface NSString (FontAwesome)

+ (NSString *)stringFromAwesomeIcon:(FAIcon)icon;
- (NSString *)trimWhitespace;
- (BOOL)isEmpty;

@end