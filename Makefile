.PHONY : check_env build build_arm64 build_debug_arm64 package package_arm64 app app_arm64 app_debug_arm64 build_buckdebug build_verbose kill_xcode clean project project_buckdebug temp

export BUCK=buck
export TELEGRAM_ENV_SET=1
export DEVELOPMENT_CODE_SIGN_IDENTITY=iPhone Distribution: Digital Fortress LLC (C67CF9S4VU)
export DISTRIBUTION_CODE_SIGN_IDENTITY=iPhone Distribution: Digital Fortress LLC (C67CF9S4VU)
export DEVELOPMENT_TEAM=C67CF9S4VU
export API_ID=8
export API_HASH=7245de8e747a0d6fbe11f7cc14fcc0bb
export BUNDLE_ID=ph.telegra.Telegraph
export IS_INTERNAL_BUILD=false
export IS_APPSTORE_BUILD=true
export APPSTORE_ID=686449807
export APP_SPECIFIC_URL_SCHEME=tgapp
export BUILD_NUMBER=199
export ENTITLEMENTS_APP=Telegram-iOS/Telegram-iOS-AppStoreLLC.entitlements
export DEVELOPMENT_PROVISIONING_PROFILE_APP=match Development ph.telegra.Telegraph
export DISTRIBUTION_PROVISIONING_PROFILE_APP=match AppStore ph.telegra.Telegraph
export ENTITLEMENTS_EXTENSION_SHARE=Share/Share-AppStoreLLC.entitlements
export DEVELOPMENT_PROVISIONING_PROFILE_EXTENSION_SHARE=match Development ph.telegra.Telegraph.Share
export DISTRIBUTION_PROVISIONING_PROFILE_EXTENSION_SHARE=match AppStore ph.telegra.Telegraph.Share
export ENTITLEMENTS_EXTENSION_WIDGET=Widget/Widget-AppStoreLLC.entitlements
export DEVELOPMENT_PROVISIONING_PROFILE_EXTENSION_WIDGET=match Development ph.telegra.Telegraph.Widget
export DISTRIBUTION_PROVISIONING_PROFILE_EXTENSION_WIDGET=match AppStore ph.telegra.Telegraph.Widget
export ENTITLEMENTS_EXTENSION_NOTIFICATIONSERVICE=NotificationService/NotificationService-AppStoreLLC.entitlements
export DEVELOPMENT_PROVISIONING_PROFILE_EXTENSION_NOTIFICATIONSERVICE=match Development ph.telegra.Telegraph.NotificationService
export DISTRIBUTION_PROVISIONING_PROFILE_EXTENSION_NOTIFICATIONSERVICE=match AppStore ph.telegra.Telegraph.NotificationService
export ENTITLEMENTS_EXTENSION_NOTIFICATIONCONTENT=NotificationContent/NotificationContent-AppStoreLLC.entitlements
export DEVELOPMENT_PROVISIONING_PROFILE_EXTENSION_NOTIFICATIONCONTENT=match Development ph.telegra.Telegraph.NotificationContent
export DISTRIBUTION_PROVISIONING_PROFILE_EXTENSION_NOTIFICATIONCONTENT=match AppStore ph.telegra.Telegraph.NotificationContent
export ENTITLEMENTS_EXTENSION_INTENTS=SiriIntents/SiriIntents-AppStoreLLC.entitlements
export DEVELOPMENT_PROVISIONING_PROFILE_EXTENSION_INTENTS=match Development ph.telegra.Telegraph.SiriIntents
export DISTRIBUTION_PROVISIONING_PROFILE_EXTENSION_INTENTS=match AppStore ph.telegra.Telegraph.SiriIntents
export DEVELOPMENT_PROVISIONING_PROFILE_WATCH_APP=match Development ph.telegra.Telegraph.watchkitapp
export DISTRIBUTION_PROVISIONING_PROFILE_WATCH_APP=match AppStore ph.telegra.Telegraph.watchkitapp
export DEVELOPMENT_PROVISIONING_PROFILE_WATCH_EXTENSION=match Development ph.telegra.Telegraph.watchkitapp.watchkitextension
export DISTRIBUTION_PROVISIONING_PROFILE_WATCH_EXTENSION=match AppStore ph.telegra.Telegraph.watchkitapp.watchkitextension
export BUILDBOX_DIR=buildbox
export CODESIGNING_PROFILES_VARIANT=appstore
export PACKAGE_METHOD=appstore

include Utils.makefile


APP_VERSION="7.0.1"
CORE_COUNT=$(shell sysctl -n hw.logicalcpu)
CORE_COUNT_MINUS_ONE=$(shell expr ${CORE_COUNT} \- 1)

BUCK_OPTIONS=\
	--config custom.appVersion="${APP_VERSION}" \
	--config custom.developmentCodeSignIdentity="${DEVELOPMENT_CODE_SIGN_IDENTITY}" \
	--config custom.distributionCodeSignIdentity="${DISTRIBUTION_CODE_SIGN_IDENTITY}" \
	--config custom.developmentTeam="${DEVELOPMENT_TEAM}" \
	--config custom.baseApplicationBundleId="${BUNDLE_ID}" \
	--config custom.apiId="${API_ID}" \
	--config custom.apiHash="${API_HASH}" \
	--config custom.appCenterId="${APP_CENTER_ID}" \
	--config custom.isInternalBuild="${IS_INTERNAL_BUILD}" \
	--config custom.isAppStoreBuild="${IS_APPSTORE_BUILD}" \
	--config custom.appStoreId="${APPSTORE_ID}" \
	--config custom.appSpecificUrlScheme="${APP_SPECIFIC_URL_SCHEME}" \
	--config custom.buildNumber="${BUILD_NUMBER}" \
	--config custom.entitlementsApp="${ENTITLEMENTS_APP}" \
	--config custom.developmentProvisioningProfileApp="${DEVELOPMENT_PROVISIONING_PROFILE_APP}" \
	--config custom.distributionProvisioningProfileApp="${DISTRIBUTION_PROVISIONING_PROFILE_APP}" \
	--config custom.entitlementsExtensionShare="${ENTITLEMENTS_EXTENSION_SHARE}" \
	--config custom.developmentProvisioningProfileExtensionShare="${DEVELOPMENT_PROVISIONING_PROFILE_EXTENSION_SHARE}" \
	--config custom.distributionProvisioningProfileExtensionShare="${DISTRIBUTION_PROVISIONING_PROFILE_EXTENSION_SHARE}" \
	--config custom.entitlementsExtensionWidget="${ENTITLEMENTS_EXTENSION_WIDGET}" \
	--config custom.developmentProvisioningProfileExtensionWidget="${DEVELOPMENT_PROVISIONING_PROFILE_EXTENSION_WIDGET}" \
	--config custom.distributionProvisioningProfileExtensionWidget="${DISTRIBUTION_PROVISIONING_PROFILE_EXTENSION_WIDGET}" \
	--config custom.entitlementsExtensionNotificationService="${ENTITLEMENTS_EXTENSION_NOTIFICATIONSERVICE}" \
	--config custom.developmentProvisioningProfileExtensionNotificationService="${DEVELOPMENT_PROVISIONING_PROFILE_EXTENSION_NOTIFICATIONSERVICE}" \
	--config custom.distributionProvisioningProfileExtensionNotificationService="${DISTRIBUTION_PROVISIONING_PROFILE_EXTENSION_NOTIFICATIONSERVICE}" \
	--config custom.entitlementsExtensionNotificationContent="${ENTITLEMENTS_EXTENSION_NOTIFICATIONCONTENT}" \
	--config custom.developmentProvisioningProfileExtensionNotificationContent="${DEVELOPMENT_PROVISIONING_PROFILE_EXTENSION_NOTIFICATIONCONTENT}" \
	--config custom.distributionProvisioningProfileExtensionNotificationContent="${DISTRIBUTION_PROVISIONING_PROFILE_EXTENSION_NOTIFICATIONCONTENT}" \
	--config custom.entitlementsExtensionIntents="${ENTITLEMENTS_EXTENSION_INTENTS}" \
	--config custom.developmentProvisioningProfileExtensionIntents="${DEVELOPMENT_PROVISIONING_PROFILE_EXTENSION_INTENTS}" \
	--config custom.distributionProvisioningProfileExtensionIntents="${DISTRIBUTION_PROVISIONING_PROFILE_EXTENSION_INTENTS}" \
	--config custom.developmentProvisioningProfileWatchApp="${DEVELOPMENT_PROVISIONING_PROFILE_WATCH_APP}" \
	--config custom.distributionProvisioningProfileWatchApp="${DISTRIBUTION_PROVISIONING_PROFILE_WATCH_APP}" \
	--config custom.developmentProvisioningProfileWatchExtension="${DEVELOPMENT_PROVISIONING_PROFILE_WATCH_EXTENSION}" \
	--config custom.distributionProvisioningProfileWatchExtension="${DISTRIBUTION_PROVISIONING_PROFILE_WATCH_EXTENSION}"

BAZEL=$(shell which bazel)

ifneq ($(BAZEL_CACHE_DIR),)
	export BAZEL_CACHE_FLAGS=\
		--disk_cache="${BAZEL_CACHE_DIR}"
endif

BAZEL_COMMON_FLAGS=\
	--announce_rc \
	--features=swift.use_global_module_cache \
	
BAZEL_DEBUG_FLAGS=\
	--features=swift.enable_batch_mode \
	--swiftcopt=-j${CORE_COUNT_MINUS_ONE} \

BAZEL_OPT_FLAGS=\
	--swiftcopt=-whole-module-optimization \
	--swiftcopt='-num-threads' --swiftcopt='16' \


build_arm64: check_env
	$(BUCK) build \
	//Telegram:AppPackage#iphoneos-arm64 \
	//Telegram:Telegram#dwarf-and-dsym,iphoneos-arm64 \
	//submodules/MtProtoKit:MtProtoKit#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/MtProtoKit:MtProtoKit#shared,iphoneos-arm64 \
	//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit#shared,iphoneos-arm64 \
	//submodules/Postbox:Postbox#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/Postbox:Postbox#shared,iphoneos-arm64 \
	//submodules/TelegramApi:TelegramApi#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/TelegramApi:TelegramApi#shared,iphoneos-arm64 \
	//submodules/SyncCore:SyncCore#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/SyncCore:SyncCore#shared,iphoneos-arm64 \
	//submodules/TelegramCore:TelegramCore#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/TelegramCore:TelegramCore#shared,iphoneos-arm64 \
	//submodules/AsyncDisplayKit:AsyncDisplayKit#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/AsyncDisplayKit:AsyncDisplayKit#shared,iphoneos-arm64 \
	//submodules/Display:Display#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/Display:Display#shared,iphoneos-arm64 \
	//submodules/TelegramUI:TelegramUI#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/TelegramUI:TelegramUI#shared,iphoneos-arm64 \
	//Telegram:WatchAppExtension#dwarf-and-dsym,watchos-arm64_32,watchos-armv7k \
	//Telegram:ShareExtension#dwarf-and-dsym,iphoneos-arm64 \
    //Telegram:WidgetExtension#dwarf-and-dsym,iphoneos-arm64 \
    //Telegram:NotificationContentExtension#dwarf-and-dsym,iphoneos-arm64 \
    //Telegram:NotificationServiceExtension#dwarf-and-dsym,iphoneos-arm64 \
    //Telegram:IntentsExtension#dwarf-and-dsym,iphoneos-arm64 \
	${BUCK_OPTIONS} ${BUCK_RELEASE_OPTIONS} ${BUCK_THREADS_OPTIONS} ${BUCK_CACHE_OPTIONS}

build_debug_arm64: check_env
	$(BUCK) build \
	//Telegram:AppPackage#iphoneos-arm64 \
	//Telegram:Telegram#dwarf-and-dsym,iphoneos-arm64 \
	//submodules/MtProtoKit:MtProtoKit#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/MtProtoKit:MtProtoKit#shared,iphoneos-arm64 \
	//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit#shared,iphoneos-arm64 \
	//submodules/Postbox:Postbox#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/Postbox:Postbox#shared,iphoneos-arm64 \
	//submodules/TelegramApi:TelegramApi#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/TelegramApi:TelegramApi#shared,iphoneos-arm64 \
	//submodules/SyncCore:SyncCore#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/SyncCore:SyncCore#shared,iphoneos-arm64 \
	//submodules/TelegramCore:TelegramCore#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/TelegramCore:TelegramCore#shared,iphoneos-arm64 \
	//submodules/AsyncDisplayKit:AsyncDisplayKit#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/AsyncDisplayKit:AsyncDisplayKit#shared,iphoneos-arm64 \
	//submodules/Display:Display#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/Display:Display#shared,iphoneos-arm64 \
	//submodules/TelegramUI:TelegramUI#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/TelegramUI:TelegramUI#shared,iphoneos-arm64 \
	//Telegram:WatchAppExtension#dwarf-and-dsym,watchos-arm64_32,watchos-armv7k \
	//Telegram:ShareExtension#dwarf-and-dsym,iphoneos-arm64 \
    //Telegram:WidgetExtension#dwarf-and-dsym,iphoneos-arm64 \
    //Telegram:NotificationContentExtension#dwarf-and-dsym,iphoneos-arm64 \
    //Telegram:NotificationServiceExtension#dwarf-and-dsym,iphoneos-arm64 \
    //Telegram:IntentsExtension#dwarf-and-dsym,iphoneos-arm64 \
	${BUCK_OPTIONS} ${BUCK_DEBUG_OPTIONS} ${BUCK_THREADS_OPTIONS} ${BUCK_CACHE_OPTIONS}

build_wallet_debug_arm64: check_env
	$(BUCK) build \
	//Wallet:AppPackage#iphoneos-arm64 \
	//Wallet:Wallet#dwarf-and-dsym,iphoneos-arm64 \
	//submodules/MtProtoKit:MtProtoKit#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/MtProtoKit:MtProtoKit#shared,iphoneos-arm64 \
	//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit#shared,iphoneos-arm64 \
	//submodules/AsyncDisplayKit:AsyncDisplayKit#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/AsyncDisplayKit:AsyncDisplayKit#shared,iphoneos-arm64 \
	//submodules/Display:Display#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/Display:Display#shared,iphoneos-arm64 \
	${WALLET_BUCK_OPTIONS} ${BUCK_DEBUG_OPTIONS} ${BUCK_THREADS_OPTIONS} ${BUCK_CACHE_OPTIONS}

build_debug_armv7: check_env
	$(BUCK) build \
	//Telegram:AppPackage#iphoneos-armv7 \
	//Telegram:Telegram#dwarf-and-dsym,iphoneos-armv7 \
	//submodules/MtProtoKit:MtProtoKit#dwarf-and-dsym,shared,iphoneos-armv7 \
	//submodules/MtProtoKit:MtProtoKit#shared,iphoneos-armv7 \
	//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit#dwarf-and-dsym,shared,iphoneos-armv7 \
	//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit#shared,iphoneos-armv7 \
	//submodules/Postbox:Postbox#dwarf-and-dsym,shared,iphoneos-armv7 \
	//submodules/Postbox:Postbox#shared,iphoneos-armv7 \
	//submodules/TelegramApi:TelegramApi#dwarf-and-dsym,shared,iphoneos-armv7 \
	//submodules/TelegramApi:TelegramApi#shared,iphoneos-armv7 \
	//submodules/SyncCore:SyncCore#dwarf-and-dsym,shared,iphoneos-armv7 \
	//submodules/SyncCore:SyncCore#shared,iphoneos-armv7 \
	//submodules/TelegramCore:TelegramCore#dwarf-and-dsym,shared,iphoneos-armv7 \
	//submodules/TelegramCore:TelegramCore#shared,iphoneos-armv7 \
	//submodules/AsyncDisplayKit:AsyncDisplayKit#dwarf-and-dsym,shared,iphoneos-armv7 \
	//submodules/AsyncDisplayKit:AsyncDisplayKit#shared,iphoneos-armv7 \
	//submodules/Display:Display#dwarf-and-dsym,shared,iphoneos-armv7 \
	//submodules/Display:Display#shared,iphoneos-armv7 \
	//submodules/TelegramUI:TelegramUI#dwarf-and-dsym,shared,iphoneos-armv7 \
	//submodules/TelegramUI:TelegramUI#shared,iphoneos-armv7 \
	//Telegram:WatchAppExtension#dwarf-and-dsym,watchos-armv7_32,watchos-armv7k \
	//Telegram:ShareExtension#dwarf-and-dsym,iphoneos-armv7 \
    //Telegram:WidgetExtension#dwarf-and-dsym,iphoneos-armv7 \
    //Telegram:NotificationContentExtension#dwarf-and-dsym,iphoneos-armv7 \
    //Telegram:NotificationServiceExtension#dwarf-and-dsym,iphoneos-armv7 \
    //Telegram:IntentsExtension#dwarf-and-dsym,iphoneos-armv7 \
	${BUCK_OPTIONS} ${BUCK_DEBUG_OPTIONS} ${BUCK_THREADS_OPTIONS} ${BUCK_CACHE_OPTIONS}

build: check_env
	$(BUCK) build \
	//Telegram:AppPackage#iphoneos-arm64,iphoneos-armv7 \
	//Telegram:Telegram#dwarf-and-dsym,iphoneos-arm64,iphoneos-armv7 \
	//submodules/MtProtoKit:MtProtoKit#dwarf-and-dsym,shared,iphoneos-arm64,iphoneos-armv7 \
	//submodules/MtProtoKit:MtProtoKit#shared,iphoneos-arm64,iphoneos-armv7 \
	//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit#dwarf-and-dsym,shared,iphoneos-arm64,iphoneos-armv7 \
	//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit#shared,iphoneos-arm64,iphoneos-armv7 \
	//submodules/Postbox:Postbox#dwarf-and-dsym,shared,iphoneos-arm64,iphoneos-armv7 \
	//submodules/Postbox:Postbox#shared,iphoneos-arm64,iphoneos-armv7 \
	//submodules/TelegramApi:TelegramApi#dwarf-and-dsym,shared,iphoneos-arm64,iphoneos-armv7 \
	//submodules/TelegramApi:TelegramApi#shared,iphoneos-arm64,iphoneos-armv7 \
	//submodules/SyncCore:SyncCore#dwarf-and-dsym,shared,iphoneos-arm64,iphoneos-armv7 \
	//submodules/SyncCore:SyncCore#shared,iphoneos-arm64,iphoneos-armv7 \
	//submodules/TelegramCore:TelegramCore#dwarf-and-dsym,shared,iphoneos-arm64,iphoneos-armv7 \
	//submodules/TelegramCore:TelegramCore#shared,iphoneos-arm64,iphoneos-armv7 \
	//submodules/AsyncDisplayKit:AsyncDisplayKit#dwarf-and-dsym,shared,iphoneos-arm64,iphoneos-armv7 \
	//submodules/AsyncDisplayKit:AsyncDisplayKit#shared,iphoneos-arm64,iphoneos-armv7 \
	//submodules/Display:Display#dwarf-and-dsym,shared,iphoneos-arm64,iphoneos-armv7 \
	//submodules/Display:Display#shared,iphoneos-arm64,iphoneos-armv7 \
	//submodules/TelegramUI:TelegramUI#dwarf-and-dsym,shared,iphoneos-arm64,iphoneos-armv7 \
	//submodules/TelegramUI:TelegramUI#shared,iphoneos-arm64,iphoneos-armv7 \
	//Telegram:WatchAppExtension#dwarf-and-dsym,watchos-arm64_32,watchos-armv7k \
	//Telegram:ShareExtension#dwarf-and-dsym,iphoneos-arm64,iphoneos-armv7 \
    //Telegram:WidgetExtension#dwarf-and-dsym,iphoneos-arm64,iphoneos-armv7 \
    //Telegram:NotificationContentExtension#dwarf-and-dsym,iphoneos-arm64,iphoneos-armv7 \
    //Telegram:NotificationServiceExtension#dwarf-and-dsym,iphoneos-arm64,iphoneos-armv7 \
    //Telegram:IntentsExtension#dwarf-and-dsym,iphoneos-arm64,iphoneos-armv7 \
	${BUCK_OPTIONS} ${BUCK_RELEASE_OPTIONS} ${BUCK_THREADS_OPTIONS} ${BUCK_CACHE_OPTIONS}

package_arm64:
	PACKAGE_DEVELOPMENT_TEAM="${DEVELOPMENT_TEAM}" \
	PACKAGE_CODE_SIGN_IDENTITY="${DISTRIBUTION_CODE_SIGN_IDENTITY}" \
	PACKAGE_PROVISIONING_PROFILE_APP="${DISTRIBUTION_PROVISIONING_PROFILE_APP}" \
	PACKAGE_ENTITLEMENTS_APP="Telegram/${ENTITLEMENTS_APP}" \
	PACKAGE_PROVISIONING_PROFILE_EXTENSION_Share="${DISTRIBUTION_PROVISIONING_PROFILE_EXTENSION_SHARE}" \
	PACKAGE_ENTITLEMENTS_EXTENSION_Share="Telegram/${ENTITLEMENTS_EXTENSION_SHARE}" \
	PACKAGE_PROVISIONING_PROFILE_EXTENSION_Widget="${DISTRIBUTION_PROVISIONING_PROFILE_EXTENSION_WIDGET}" \
	PACKAGE_ENTITLEMENTS_EXTENSION_Widget="Telegram/${ENTITLEMENTS_EXTENSION_WIDGET}" \
	PACKAGE_PROVISIONING_PROFILE_EXTENSION_NotificationService="${DISTRIBUTION_PROVISIONING_PROFILE_EXTENSION_NOTIFICATIONSERVICE}" \
	PACKAGE_ENTITLEMENTS_EXTENSION_NotificationService="Telegram/${ENTITLEMENTS_EXTENSION_NOTIFICATIONSERVICE}" \
	PACKAGE_PROVISIONING_PROFILE_EXTENSION_NotificationContent="${DISTRIBUTION_PROVISIONING_PROFILE_EXTENSION_NOTIFICATIONCONTENT}" \
	PACKAGE_ENTITLEMENTS_EXTENSION_NotificationContent="Telegram/${ENTITLEMENTS_EXTENSION_NOTIFICATIONCONTENT}" \
	PACKAGE_PROVISIONING_PROFILE_EXTENSION_Intents="${DISTRIBUTION_PROVISIONING_PROFILE_EXTENSION_INTENTS}" \
	PACKAGE_ENTITLEMENTS_EXTENSION_Intents="Telegram/${ENTITLEMENTS_EXTENSION_INTENTS}" \
	PACKAGE_PROVISIONING_PROFILE_WATCH_APP="${DISTRIBUTION_PROVISIONING_PROFILE_WATCH_APP}" \
	PACKAGE_PROVISIONING_PROFILE_WATCH_EXTENSION="${DISTRIBUTION_PROVISIONING_PROFILE_WATCH_EXTENSION}" \
	PACKAGE_BUNDLE_ID="${BUNDLE_ID}" \
	sh package_app.sh iphoneos-arm64 $(BUCK) "telegram" $(BUCK_OPTIONS) ${BUCK_RELEASE_OPTIONS}

package_armv7:
	PACKAGE_DEVELOPMENT_TEAM="${DEVELOPMENT_TEAM}" \
	PACKAGE_CODE_SIGN_IDENTITY="${DISTRIBUTION_CODE_SIGN_IDENTITY}" \
	PACKAGE_PROVISIONING_PROFILE_APP="${DISTRIBUTION_PROVISIONING_PROFILE_APP}" \
	PACKAGE_ENTITLEMENTS_APP="Telegram/${ENTITLEMENTS_APP}" \
	PACKAGE_PROVISIONING_PROFILE_EXTENSION_Share="${DISTRIBUTION_PROVISIONING_PROFILE_EXTENSION_SHARE}" \
	PACKAGE_ENTITLEMENTS_EXTENSION_Share="Telegram/${ENTITLEMENTS_EXTENSION_SHARE}" \
	PACKAGE_PROVISIONING_PROFILE_EXTENSION_Widget="${DISTRIBUTION_PROVISIONING_PROFILE_EXTENSION_WIDGET}" \
	PACKAGE_ENTITLEMENTS_EXTENSION_Widget="Telegram/${ENTITLEMENTS_EXTENSION_WIDGET}" \
	PACKAGE_PROVISIONING_PROFILE_EXTENSION_NotificationService="${DISTRIBUTION_PROVISIONING_PROFILE_EXTENSION_NOTIFICATIONSERVICE}" \
	PACKAGE_ENTITLEMENTS_EXTENSION_NotificationService="Telegram/${ENTITLEMENTS_EXTENSION_NOTIFICATIONSERVICE}" \
	PACKAGE_PROVISIONING_PROFILE_EXTENSION_NotificationContent="${DISTRIBUTION_PROVISIONING_PROFILE_EXTENSION_NOTIFICATIONCONTENT}" \
	PACKAGE_ENTITLEMENTS_EXTENSION_NotificationContent="Telegram/${ENTITLEMENTS_EXTENSION_NOTIFICATIONCONTENT}" \
	PACKAGE_PROVISIONING_PROFILE_EXTENSION_Intents="${DISTRIBUTION_PROVISIONING_PROFILE_EXTENSION_INTENTS}" \
	PACKAGE_ENTITLEMENTS_EXTENSION_Intents="Telegram/${ENTITLEMENTS_EXTENSION_INTENTS}" \
	PACKAGE_PROVISIONING_PROFILE_WATCH_APP="${DISTRIBUTION_PROVISIONING_PROFILE_WATCH_APP}" \
	PACKAGE_PROVISIONING_PROFILE_WATCH_EXTENSION="${DISTRIBUTION_PROVISIONING_PROFILE_WATCH_EXTENSION}" \
	PACKAGE_BUNDLE_ID="${BUNDLE_ID}" \
	sh package_app.sh iphoneos-armv7 $(BUCK) "telegram" $(BUCK_OPTIONS) ${BUCK_RELEASE_OPTIONS}

package_debug_arm64:
	PACKAGE_DEVELOPMENT_TEAM="${DEVELOPMENT_TEAM}" \
	PACKAGE_CODE_SIGN_IDENTITY="${DEVELOPMENT_CODE_SIGN_IDENTITY}" \
	PACKAGE_PROVISIONING_PROFILE_APP="${DEVELOPMENT_PROVISIONING_PROFILE_APP}" \
	PACKAGE_ENTITLEMENTS_APP="Telegram/${ENTITLEMENTS_APP}" \
	PACKAGE_PROVISIONING_PROFILE_EXTENSION_Share="${DEVELOPMENT_PROVISIONING_PROFILE_EXTENSION_SHARE}" \
	PACKAGE_ENTITLEMENTS_EXTENSION_Share="Telegram/${ENTITLEMENTS_EXTENSION_SHARE}" \
	PACKAGE_PROVISIONING_PROFILE_EXTENSION_Widget="${DEVELOPMENT_PROVISIONING_PROFILE_EXTENSION_WIDGET}" \
	PACKAGE_ENTITLEMENTS_EXTENSION_Widget="Telegram/${ENTITLEMENTS_EXTENSION_WIDGET}" \
	PACKAGE_PROVISIONING_PROFILE_EXTENSION_NotificationService="${DEVELOPMENT_PROVISIONING_PROFILE_EXTENSION_NOTIFICATIONSERVICE}" \
	PACKAGE_ENTITLEMENTS_EXTENSION_NotificationService="Telegram/${ENTITLEMENTS_EXTENSION_NOTIFICATIONSERVICE}" \
	PACKAGE_PROVISIONING_PROFILE_EXTENSION_NotificationContent="${DEVELOPMENT_PROVISIONING_PROFILE_EXTENSION_NOTIFICATIONCONTENT}" \
	PACKAGE_ENTITLEMENTS_EXTENSION_NotificationContent="Telegram/${ENTITLEMENTS_EXTENSION_NOTIFICATIONCONTENT}" \
	PACKAGE_PROVISIONING_PROFILE_EXTENSION_Intents="${DEVELOPMENT_PROVISIONING_PROFILE_EXTENSION_INTENTS}" \
	PACKAGE_ENTITLEMENTS_EXTENSION_Intents="Telegram/${ENTITLEMENTS_EXTENSION_INTENTS}" \
	PACKAGE_PROVISIONING_PROFILE_WATCH_APP="${DEVELOPMENT_PROVISIONING_PROFILE_WATCH_APP}" \
	PACKAGE_PROVISIONING_PROFILE_WATCH_EXTENSION="${DEVELOPMENT_PROVISIONING_PROFILE_WATCH_EXTENSION}" \
	PACKAGE_BUNDLE_ID="${BUNDLE_ID}" \
	ENABLE_GET_TASK_ALLOW=0 \
	CODESIGNING_PROFILES_VARIANT="development" \
	sh package_app.sh iphoneos-arm64 $(BUCK) "telegram" $(BUCK_OPTIONS) ${BUCK_RELEASE_OPTIONS}

package_debug_armv7:
	PACKAGE_DEVELOPMENT_TEAM="${DEVELOPMENT_TEAM}" \
	PACKAGE_CODE_SIGN_IDENTITY="${DEVELOPMENT_CODE_SIGN_IDENTITY}" \
	PACKAGE_PROVISIONING_PROFILE_APP="${DEVELOPMENT_PROVISIONING_PROFILE_APP}" \
	PACKAGE_ENTITLEMENTS_APP="Telegram/${ENTITLEMENTS_APP}" \
	PACKAGE_PROVISIONING_PROFILE_EXTENSION_Share="${DEVELOPMENT_PROVISIONING_PROFILE_EXTENSION_SHARE}" \
	PACKAGE_ENTITLEMENTS_EXTENSION_Share="Telegram/${ENTITLEMENTS_EXTENSION_SHARE}" \
	PACKAGE_PROVISIONING_PROFILE_EXTENSION_Widget="${DEVELOPMENT_PROVISIONING_PROFILE_EXTENSION_WIDGET}" \
	PACKAGE_ENTITLEMENTS_EXTENSION_Widget="Telegram/${ENTITLEMENTS_EXTENSION_WIDGET}" \
	PACKAGE_PROVISIONING_PROFILE_EXTENSION_NotificationService="${DEVELOPMENT_PROVISIONING_PROFILE_EXTENSION_NOTIFICATIONSERVICE}" \
	PACKAGE_ENTITLEMENTS_EXTENSION_NotificationService="Telegram/${ENTITLEMENTS_EXTENSION_NOTIFICATIONSERVICE}" \
	PACKAGE_PROVISIONING_PROFILE_EXTENSION_NotificationContent="${DEVELOPMENT_PROVISIONING_PROFILE_EXTENSION_NOTIFICATIONCONTENT}" \
	PACKAGE_ENTITLEMENTS_EXTENSION_NotificationContent="Telegram/${ENTITLEMENTS_EXTENSION_NOTIFICATIONCONTENT}" \
	PACKAGE_PROVISIONING_PROFILE_EXTENSION_Intents="${DEVELOPMENT_PROVISIONING_PROFILE_EXTENSION_INTENTS}" \
	PACKAGE_ENTITLEMENTS_EXTENSION_Intents="Telegram/${ENTITLEMENTS_EXTENSION_INTENTS}" \
	PACKAGE_PROVISIONING_PROFILE_WATCH_APP="${DEVELOPMENT_PROVISIONING_PROFILE_WATCH_APP}" \
	PACKAGE_PROVISIONING_PROFILE_WATCH_EXTENSION="${DEVELOPMENT_PROVISIONING_PROFILE_WATCH_EXTENSION}" \
	PACKAGE_BUNDLE_ID="${BUNDLE_ID}" \
	ENABLE_GET_TASK_ALLOW=0 \
	CODESIGNING_PROFILES_VARIANT="development" \
	sh package_app.sh iphoneos-armv7 $(BUCK) "telegram" $(BUCK_OPTIONS) ${BUCK_RELEASE_OPTIONS}

package:
	PACKAGE_DEVELOPMENT_TEAM="${DEVELOPMENT_TEAM}" \
	PACKAGE_CODE_SIGN_IDENTITY="${DISTRIBUTION_CODE_SIGN_IDENTITY}" \
	PACKAGE_PROVISIONING_PROFILE_APP="${DISTRIBUTION_PROVISIONING_PROFILE_APP}" \
	PACKAGE_ENTITLEMENTS_APP="Telegram/${ENTITLEMENTS_APP}" \
	PACKAGE_PROVISIONING_PROFILE_EXTENSION_Share="${DISTRIBUTION_PROVISIONING_PROFILE_EXTENSION_SHARE}" \
	PACKAGE_ENTITLEMENTS_EXTENSION_Share="Telegram/${ENTITLEMENTS_EXTENSION_SHARE}" \
	PACKAGE_PROVISIONING_PROFILE_EXTENSION_Widget="${DISTRIBUTION_PROVISIONING_PROFILE_EXTENSION_WIDGET}" \
	PACKAGE_ENTITLEMENTS_EXTENSION_Widget="Telegram/${ENTITLEMENTS_EXTENSION_WIDGET}" \
	PACKAGE_PROVISIONING_PROFILE_EXTENSION_NotificationService="${DISTRIBUTION_PROVISIONING_PROFILE_EXTENSION_NOTIFICATIONSERVICE}" \
	PACKAGE_ENTITLEMENTS_EXTENSION_NotificationService="Telegram/${ENTITLEMENTS_EXTENSION_NOTIFICATIONSERVICE}" \
	PACKAGE_PROVISIONING_PROFILE_EXTENSION_NotificationContent="${DISTRIBUTION_PROVISIONING_PROFILE_EXTENSION_NOTIFICATIONCONTENT}" \
	PACKAGE_ENTITLEMENTS_EXTENSION_NotificationContent="Telegram/${ENTITLEMENTS_EXTENSION_NOTIFICATIONCONTENT}" \
	PACKAGE_PROVISIONING_PROFILE_EXTENSION_Intents="${DISTRIBUTION_PROVISIONING_PROFILE_EXTENSION_INTENTS}" \
	PACKAGE_ENTITLEMENTS_EXTENSION_Intents="Telegram/${ENTITLEMENTS_EXTENSION_INTENTS}" \
	PACKAGE_PROVISIONING_PROFILE_WATCH_APP="${DISTRIBUTION_PROVISIONING_PROFILE_WATCH_APP}" \
	PACKAGE_PROVISIONING_PROFILE_WATCH_EXTENSION="${DISTRIBUTION_PROVISIONING_PROFILE_WATCH_EXTENSION}" \
	PACKAGE_BUNDLE_ID="${BUNDLE_ID}" \
	sh package_app.sh iphoneos-arm64,iphoneos-armv7 $(BUCK) "telegram" $(BUCK_OPTIONS) ${BUCK_RELEASE_OPTIONS}

app: build package

app_arm64: build_arm64 package_arm64

app_debug_arm64: build_debug_arm64 package_debug_arm64

wallet_debug_arm64: build_wallet_debug_arm64

app_debug_armv7: build_debug_armv7 package_debug_armv7

build_buckdebug: check_env
	BUCK_DEBUG_MODE=1 $(BUCK) build \
	//Telegram:AppPackage#iphoneos-arm64 \
	//Telegram:Telegram#dwarf-and-dsym,iphoneos-arm64 \
	//submodules/MtProtoKit:MtProtoKit#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/MtProtoKit:MtProtoKit#shared,iphoneos-arm64 \
	//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit#shared,iphoneos-arm64 \
	//submodules/Postbox:Postbox#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/Postbox:Postbox#shared,iphoneos-arm64 \
	//submodules/TelegramApi:TelegramApi#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/TelegramApi:TelegramApi#shared,iphoneos-arm64 \
	//submodules/SyncCore:SyncCore#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/SyncCore:SyncCore#shared,iphoneos-arm64 \
	//submodules/TelegramCore:TelegramCore#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/TelegramCore:TelegramCore#shared,iphoneos-arm64 \
	//submodules/AsyncDisplayKit:AsyncDisplayKit#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/AsyncDisplayKit:AsyncDisplayKit#shared,iphoneos-arm64 \
	//submodules/Display:Display#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/Display:Display#shared,iphoneos-arm64 \
	//submodules/TelegramUI:TelegramUI#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/TelegramUI:TelegramUI#shared,iphoneos-arm64 \
	//Telegram:WatchAppExtension#dwarf-and-dsym,watchos-arm64_32,watchos-armv7k \
	//Telegram:ShareExtension#dwarf-and-dsym,iphoneos-arm64 \
    //Telegram:WidgetExtension#dwarf-and-dsym,iphoneos-arm64 \
    //Telegram:NotificationContentExtension#dwarf-and-dsym,iphoneos-arm64 \
    //Telegram:NotificationServiceExtension#dwarf-and-dsym,iphoneos-arm64 \
    //Telegram:IntentsExtension#dwarf-and-dsym,iphoneos-arm64 \
    --verbose 7 ${BUCK_OPTIONS} ${BUCK_DEBUG_OPTIONS}

build_verbose: check_env
	$(BUCK) build \
	//Telegram:AppPackage#iphoneos-arm64 \
	//Telegram:Telegram#dwarf-and-dsym,iphoneos-arm64 \
	//submodules/MtProtoKit:MtProtoKit#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/MtProtoKit:MtProtoKit#shared,iphoneos-arm64 \
	//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit#shared,iphoneos-arm64 \
	//submodules/Postbox:Postbox#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/Postbox:Postbox#shared,iphoneos-arm64 \
	//submodules/TelegramApi:TelegramApi#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/TelegramApi:TelegramApi#shared,iphoneos-arm64 \
	//submodules/SyncCore:SyncCore#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/SyncCore:SyncCore#shared,iphoneos-arm64 \
	//submodules/TelegramCore:TelegramCore#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/TelegramCore:TelegramCore#shared,iphoneos-arm64 \
	//submodules/AsyncDisplayKit:AsyncDisplayKit#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/AsyncDisplayKit:AsyncDisplayKit#shared,iphoneos-arm64 \
	//submodules/Display:Display#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/Display:Display#shared,iphoneos-arm64 \
	//submodules/TelegramUI:TelegramUI#dwarf-and-dsym,shared,iphoneos-arm64 \
	//submodules/TelegramUI:TelegramUI#shared,iphoneos-arm64 \
	//Telegram:WatchAppExtension#dwarf-and-dsym,watchos-arm64_32,watchos-armv7k \
	//Telegram:ShareExtension#dwarf-and-dsym,iphoneos-arm64 \
	//Telegram:WidgetExtension#dwarf-and-dsym,iphoneos-arm64 \
	//Telegram:NotificationContentExtension#dwarf-and-dsym,iphoneos-arm64 \
	//Telegram:NotificationServiceExtension#dwarf-and-dsym,iphoneos-arm64 \
	//Telegram:IntentsExtension#dwarf-and-dsym,iphoneos-arm64 \
	--verbose 7 ${BUCK_OPTIONS} ${BUCK_THREADS_OPTIONS} ${BUCK_DEBUG_OPTIONS} ${BUCK_CACHE_OPTIONS}

deps: check_env
	$(BUCK) query "deps(//Telegram:AppPackage)" --dot  \
	${BUCK_OPTIONS} ${BUCK_DEBUG_OPTIONS}

clean: kill_xcode
	sh clean.sh

project: check_env kill_xcode
	$(BUCK) project //Telegram:workspace --config custom.mode=project ${BUCK_OPTIONS} ${BUCK_DEBUG_OPTIONS}
	open Telegram/Telegram_Buck.xcworkspace

bazel_app_debug_arm64:
	APP_VERSION="${APP_VERSION}" \
	build-system/prepare-build.sh Telegram distribution
	"${BAZEL}" build Telegram/Telegram ${BAZEL_CACHE_FLAGS} ${BAZEL_COMMON_FLAGS} ${BAZEL_DEBUG_FLAGS} \
	-c dbg \
	--ios_multi_cpus=arm64 \
	--watchos_cpus=armv7k,arm64_32 \
	--verbose_failures

bazel_app_arm64:
	APP_VERSION="${APP_VERSION}" \
	BAZEL_CACHE_DIR="${BAZEL_CACHE_DIR}" \
	build-system/prepare-build.sh Telegram distribution
	"${BAZEL}" build Telegram/Telegram ${BAZEL_CACHE_FLAGS} ${BAZEL_COMMON_FLAGS} ${BAZEL_OPT_FLAGS} \
	-c opt \
	--ios_multi_cpus=arm64 \
	--watchos_cpus=armv7k,arm64_32 \
	--objc_enable_binary_stripping=true \
	--features=dead_strip \
	--apple_generate_dsym \
	--output_groups=+dsyms \
	--verbose_failures

bazel_prepare_development_build:
	APP_VERSION="${APP_VERSION}" \
	BAZEL_CACHE_DIR="${BAZEL_CACHE_DIR}" \
	build-system/prepare-build.sh Telegram development

bazel_project: kill_xcode bazel_prepare_development_build
	APP_VERSION="${APP_VERSION}" \
	BAZEL_CACHE_DIR="${BAZEL_CACHE_DIR}" \
	build-system/generate-xcode-project.sh Telegram

bazel_soft_project: bazel_prepare_development_build
	APP_VERSION="${APP_VERSION}" \
	BAZEL_CACHE_DIR="${BAZEL_CACHE_DIR}" \
	build-system/generate-xcode-project.sh Telegram

bazel_opt_project: bazel_prepare_development_build
	APP_VERSION="${APP_VERSION}" \
	BAZEL_CACHE_DIR="${BAZEL_CACHE_DIR}" \
	GENERATE_OPT_PROJECT=1 \
	build-system/generate-xcode-project.sh Telegram

