﻿<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
    <PropertyGroup>
        <ProjectGuid>{5459C08A-6FE4-42B7-BCA7-069D0C3E189F}</ProjectGuid>
        <MainSource>OrionHelpers.dpk</MainSource>
        <ProjectVersion>20.1</ProjectVersion>
        <FrameworkType>None</FrameworkType>
        <Base>True</Base>
        <Config Condition="'$(Config)'==''">Debug</Config>
        <Platform Condition="'$(Platform)'==''">Win32</Platform>
        <TargetedPlatforms>1</TargetedPlatforms>
        <AppType>Package</AppType>
    </PropertyGroup>
    <PropertyGroup Condition="'$(Config)'=='Base' or '$(Base)'!=''">
        <Base>true</Base>
    </PropertyGroup>
    <PropertyGroup Condition="('$(Platform)'=='Android' and '$(Base)'=='true') or '$(Base_Android)'!=''">
        <Base_Android>true</Base_Android>
        <CfgParent>Base</CfgParent>
        <Base>true</Base>
    </PropertyGroup>
    <PropertyGroup Condition="('$(Platform)'=='Android64' and '$(Base)'=='true') or '$(Base_Android64)'!=''">
        <Base_Android64>true</Base_Android64>
        <CfgParent>Base</CfgParent>
        <Base>true</Base>
    </PropertyGroup>
    <PropertyGroup Condition="('$(Platform)'=='iOSDevice64' and '$(Base)'=='true') or '$(Base_iOSDevice64)'!=''">
        <Base_iOSDevice64>true</Base_iOSDevice64>
        <CfgParent>Base</CfgParent>
        <Base>true</Base>
    </PropertyGroup>
    <PropertyGroup Condition="('$(Platform)'=='iOSSimARM64' and '$(Base)'=='true') or '$(Base_iOSSimARM64)'!=''">
        <Base_iOSSimARM64>true</Base_iOSSimARM64>
        <CfgParent>Base</CfgParent>
        <Base>true</Base>
    </PropertyGroup>
    <PropertyGroup Condition="('$(Platform)'=='Win32' and '$(Base)'=='true') or '$(Base_Win32)'!=''">
        <Base_Win32>true</Base_Win32>
        <CfgParent>Base</CfgParent>
        <Base>true</Base>
    </PropertyGroup>
    <PropertyGroup Condition="'$(Config)'=='Debug' or '$(Cfg_1)'!=''">
        <Cfg_1>true</Cfg_1>
        <CfgParent>Base</CfgParent>
        <Base>true</Base>
    </PropertyGroup>
    <PropertyGroup Condition="('$(Platform)'=='Win32' and '$(Cfg_1)'=='true') or '$(Cfg_1_Win32)'!=''">
        <Cfg_1_Win32>true</Cfg_1_Win32>
        <CfgParent>Cfg_1</CfgParent>
        <Cfg_1>true</Cfg_1>
        <Base>true</Base>
    </PropertyGroup>
    <PropertyGroup Condition="'$(Config)'=='Release' or '$(Cfg_2)'!=''">
        <Cfg_2>true</Cfg_2>
        <CfgParent>Base</CfgParent>
        <Base>true</Base>
    </PropertyGroup>
    <PropertyGroup Condition="'$(Base)'!=''">
        <DCC_DcuOutput>.\$(Platform)\$(Config)</DCC_DcuOutput>
        <DCC_ExeOutput>.\$(Platform)\$(Config)</DCC_ExeOutput>
        <DCC_E>false</DCC_E>
        <DCC_N>false</DCC_N>
        <DCC_S>false</DCC_S>
        <DCC_F>false</DCC_F>
        <DCC_K>false</DCC_K>
        <GenDll>true</GenDll>
        <GenPackage>true</GenPackage>
        <DCC_Namespace>System;Xml;Data;Datasnap;Web;Soap;$(DCC_Namespace)</DCC_Namespace>
        <DCC_CBuilderOutput>All</DCC_CBuilderOutput>
        <SanitizedProjectName>OrionHelpers</SanitizedProjectName>
    </PropertyGroup>
    <PropertyGroup Condition="'$(Base_Android)'!=''">
        <DCC_CBuilderOutput>None</DCC_CBuilderOutput>
        <EnabledSysJars>activity-1.7.2.dex.jar;annotation-experimental-1.3.0.dex.jar;annotation-jvm-1.6.0.dex.jar;annotations-13.0.dex.jar;appcompat-1.2.0.dex.jar;appcompat-resources-1.2.0.dex.jar;billing-6.0.1.dex.jar;biometric-1.1.0.dex.jar;browser-1.4.0.dex.jar;cloud-messaging.dex.jar;collection-1.1.0.dex.jar;concurrent-futures-1.1.0.dex.jar;core-1.10.1.dex.jar;core-common-2.2.0.dex.jar;core-ktx-1.10.1.dex.jar;core-runtime-2.2.0.dex.jar;cursoradapter-1.0.0.dex.jar;customview-1.0.0.dex.jar;documentfile-1.0.0.dex.jar;drawerlayout-1.0.0.dex.jar;error_prone_annotations-2.9.0.dex.jar;exifinterface-1.3.6.dex.jar;firebase-annotations-16.2.0.dex.jar;firebase-common-20.3.1.dex.jar;firebase-components-17.1.0.dex.jar;firebase-datatransport-18.1.7.dex.jar;firebase-encoders-17.0.0.dex.jar;firebase-encoders-json-18.0.0.dex.jar;firebase-encoders-proto-16.0.0.dex.jar;firebase-iid-interop-17.1.0.dex.jar;firebase-installations-17.1.3.dex.jar;firebase-installations-interop-17.1.0.dex.jar;firebase-measurement-connector-19.0.0.dex.jar;firebase-messaging-23.1.2.dex.jar;fmx.dex.jar;fragment-1.2.5.dex.jar;google-play-licensing.dex.jar;interpolator-1.0.0.dex.jar;javax.inject-1.dex.jar;kotlin-stdlib-1.8.22.dex.jar;kotlin-stdlib-common-1.8.22.dex.jar;kotlin-stdlib-jdk7-1.8.22.dex.jar;kotlin-stdlib-jdk8-1.8.22.dex.jar;kotlinx-coroutines-android-1.6.4.dex.jar;kotlinx-coroutines-core-jvm-1.6.4.dex.jar;legacy-support-core-utils-1.0.0.dex.jar;lifecycle-common-2.6.1.dex.jar;lifecycle-livedata-2.6.1.dex.jar;lifecycle-livedata-core-2.6.1.dex.jar;lifecycle-runtime-2.6.1.dex.jar;lifecycle-service-2.6.1.dex.jar;lifecycle-viewmodel-2.6.1.dex.jar;lifecycle-viewmodel-savedstate-2.6.1.dex.jar;listenablefuture-1.0.dex.jar;loader-1.0.0.dex.jar;localbroadcastmanager-1.0.0.dex.jar;okio-jvm-3.4.0.dex.jar;play-services-ads-22.2.0.dex.jar;play-services-ads-base-22.2.0.dex.jar;play-services-ads-identifier-18.0.0.dex.jar;play-services-ads-lite-22.2.0.dex.jar;play-services-appset-16.0.1.dex.jar;play-services-base-18.1.0.dex.jar;play-services-basement-18.1.0.dex.jar;play-services-cloud-messaging-17.0.1.dex.jar;play-services-location-21.0.1.dex.jar;play-services-maps-18.1.0.dex.jar;play-services-measurement-base-20.1.2.dex.jar;play-services-measurement-sdk-api-20.1.2.dex.jar;play-services-stats-17.0.2.dex.jar;play-services-tasks-18.0.2.dex.jar;print-1.0.0.dex.jar;profileinstaller-1.3.0.dex.jar;room-common-2.2.5.dex.jar;room-runtime-2.2.5.dex.jar;savedstate-1.2.1.dex.jar;sqlite-2.1.0.dex.jar;sqlite-framework-2.1.0.dex.jar;startup-runtime-1.1.1.dex.jar;tracing-1.0.0.dex.jar;transport-api-3.0.0.dex.jar;transport-backend-cct-3.1.8.dex.jar;transport-runtime-3.1.8.dex.jar;user-messaging-platform-2.0.0.dex.jar;vectordrawable-1.1.0.dex.jar;vectordrawable-animated-1.1.0.dex.jar;versionedparcelable-1.1.1.dex.jar;viewpager-1.0.0.dex.jar;work-runtime-2.7.0.dex.jar</EnabledSysJars>
    </PropertyGroup>
    <PropertyGroup Condition="'$(Base_Android64)'!=''">
        <DCC_CBuilderOutput>None</DCC_CBuilderOutput>
        <EnabledSysJars>activity-1.7.2.dex.jar;annotation-experimental-1.3.0.dex.jar;annotation-jvm-1.6.0.dex.jar;annotations-13.0.dex.jar;appcompat-1.2.0.dex.jar;appcompat-resources-1.2.0.dex.jar;billing-6.0.1.dex.jar;biometric-1.1.0.dex.jar;browser-1.4.0.dex.jar;cloud-messaging.dex.jar;collection-1.1.0.dex.jar;concurrent-futures-1.1.0.dex.jar;core-1.10.1.dex.jar;core-common-2.2.0.dex.jar;core-ktx-1.10.1.dex.jar;core-runtime-2.2.0.dex.jar;cursoradapter-1.0.0.dex.jar;customview-1.0.0.dex.jar;documentfile-1.0.0.dex.jar;drawerlayout-1.0.0.dex.jar;error_prone_annotations-2.9.0.dex.jar;exifinterface-1.3.6.dex.jar;firebase-annotations-16.2.0.dex.jar;firebase-common-20.3.1.dex.jar;firebase-components-17.1.0.dex.jar;firebase-datatransport-18.1.7.dex.jar;firebase-encoders-17.0.0.dex.jar;firebase-encoders-json-18.0.0.dex.jar;firebase-encoders-proto-16.0.0.dex.jar;firebase-iid-interop-17.1.0.dex.jar;firebase-installations-17.1.3.dex.jar;firebase-installations-interop-17.1.0.dex.jar;firebase-measurement-connector-19.0.0.dex.jar;firebase-messaging-23.1.2.dex.jar;fmx.dex.jar;fragment-1.2.5.dex.jar;google-play-licensing.dex.jar;interpolator-1.0.0.dex.jar;javax.inject-1.dex.jar;kotlin-stdlib-1.8.22.dex.jar;kotlin-stdlib-common-1.8.22.dex.jar;kotlin-stdlib-jdk7-1.8.22.dex.jar;kotlin-stdlib-jdk8-1.8.22.dex.jar;kotlinx-coroutines-android-1.6.4.dex.jar;kotlinx-coroutines-core-jvm-1.6.4.dex.jar;legacy-support-core-utils-1.0.0.dex.jar;lifecycle-common-2.6.1.dex.jar;lifecycle-livedata-2.6.1.dex.jar;lifecycle-livedata-core-2.6.1.dex.jar;lifecycle-runtime-2.6.1.dex.jar;lifecycle-service-2.6.1.dex.jar;lifecycle-viewmodel-2.6.1.dex.jar;lifecycle-viewmodel-savedstate-2.6.1.dex.jar;listenablefuture-1.0.dex.jar;loader-1.0.0.dex.jar;localbroadcastmanager-1.0.0.dex.jar;okio-jvm-3.4.0.dex.jar;play-services-ads-22.2.0.dex.jar;play-services-ads-base-22.2.0.dex.jar;play-services-ads-identifier-18.0.0.dex.jar;play-services-ads-lite-22.2.0.dex.jar;play-services-appset-16.0.1.dex.jar;play-services-base-18.1.0.dex.jar;play-services-basement-18.1.0.dex.jar;play-services-cloud-messaging-17.0.1.dex.jar;play-services-location-21.0.1.dex.jar;play-services-maps-18.1.0.dex.jar;play-services-measurement-base-20.1.2.dex.jar;play-services-measurement-sdk-api-20.1.2.dex.jar;play-services-stats-17.0.2.dex.jar;play-services-tasks-18.0.2.dex.jar;print-1.0.0.dex.jar;profileinstaller-1.3.0.dex.jar;room-common-2.2.5.dex.jar;room-runtime-2.2.5.dex.jar;savedstate-1.2.1.dex.jar;sqlite-2.1.0.dex.jar;sqlite-framework-2.1.0.dex.jar;startup-runtime-1.1.1.dex.jar;tracing-1.0.0.dex.jar;transport-api-3.0.0.dex.jar;transport-backend-cct-3.1.8.dex.jar;transport-runtime-3.1.8.dex.jar;user-messaging-platform-2.0.0.dex.jar;vectordrawable-1.1.0.dex.jar;vectordrawable-animated-1.1.0.dex.jar;versionedparcelable-1.1.1.dex.jar;viewpager-1.0.0.dex.jar;work-runtime-2.7.0.dex.jar</EnabledSysJars>
    </PropertyGroup>
    <PropertyGroup Condition="'$(Base_iOSDevice64)'!=''">
        <DCC_CBuilderOutput>None</DCC_CBuilderOutput>
    </PropertyGroup>
    <PropertyGroup Condition="'$(Base_iOSSimARM64)'!=''">
        <DCC_CBuilderOutput>None</DCC_CBuilderOutput>
    </PropertyGroup>
    <PropertyGroup Condition="'$(Base_Win32)'!=''">
        <DCC_Namespace>Winapi;System.Win;Data.Win;Datasnap.Win;Web.Win;Soap.Win;Xml.Win;Bde;$(DCC_Namespace)</DCC_Namespace>
        <BT_BuildType>Debug</BT_BuildType>
        <VerInfo_IncludeVerInfo>true</VerInfo_IncludeVerInfo>
        <VerInfo_Keys>CompanyName=;FileDescription=$(MSBuildProjectName);FileVersion=1.0.0.0;InternalName=;LegalCopyright=;LegalTrademarks=;OriginalFilename=;ProgramID=com.embarcadero.$(MSBuildProjectName);ProductName=$(MSBuildProjectName);ProductVersion=1.0.0.0;Comments=</VerInfo_Keys>
        <VerInfo_Locale>1033</VerInfo_Locale>
    </PropertyGroup>
    <PropertyGroup Condition="'$(Cfg_1)'!=''">
        <DCC_Define>DEBUG;$(DCC_Define)</DCC_Define>
        <DCC_DebugDCUs>true</DCC_DebugDCUs>
        <DCC_Optimize>false</DCC_Optimize>
        <DCC_GenerateStackFrames>true</DCC_GenerateStackFrames>
        <DCC_DebugInfoInExe>true</DCC_DebugInfoInExe>
        <DCC_RemoteDebug>true</DCC_RemoteDebug>
        <DCC_IntegerOverflowCheck>true</DCC_IntegerOverflowCheck>
        <DCC_RangeChecking>true</DCC_RangeChecking>
    </PropertyGroup>
    <PropertyGroup Condition="'$(Cfg_1_Win32)'!=''">
        <DCC_RemoteDebug>false</DCC_RemoteDebug>
    </PropertyGroup>
    <PropertyGroup Condition="'$(Cfg_2)'!=''">
        <DCC_LocalDebugSymbols>false</DCC_LocalDebugSymbols>
        <DCC_Define>RELEASE;$(DCC_Define)</DCC_Define>
        <DCC_SymbolReferenceInfo>0</DCC_SymbolReferenceInfo>
        <DCC_DebugInformation>0</DCC_DebugInformation>
    </PropertyGroup>
    <ItemGroup>
        <DelphiCompile Include="$(MainSource)">
            <MainSource>MainSource</MainSource>
        </DelphiCompile>
        <DCCReference Include="rtl.dcp"/>
        <DCCReference Include="Orion.Helpers.pas"/>
        <DCCReference Include="Orion.Helpers.Reflections.pas"/>
        <BuildConfiguration Include="Base">
            <Key>Base</Key>
        </BuildConfiguration>
        <BuildConfiguration Include="Debug">
            <Key>Cfg_1</Key>
            <CfgParent>Base</CfgParent>
        </BuildConfiguration>
        <BuildConfiguration Include="Release">
            <Key>Cfg_2</Key>
            <CfgParent>Base</CfgParent>
        </BuildConfiguration>
    </ItemGroup>
    <ProjectExtensions>
        <Borland.Personality>Delphi.Personality.12</Borland.Personality>
        <Borland.ProjectType>Package</Borland.ProjectType>
        <BorlandProject>
            <Delphi.Personality>
                <Source>
                    <Source Name="MainSource">OrionHelpers.dpk</Source>
                </Source>
            </Delphi.Personality>
            <Deployment Version="4">
                <DeployFile LocalName="$(BDS)\Redist\iossimulator\libcgunwind.1.0.dylib" Class="DependencyModule">
                    <Platform Name="iOSSimulator">
                        <Overwrite>true</Overwrite>
                    </Platform>
                </DeployFile>
                <DeployFile LocalName="$(BDS)\Redist\iossimulator\libpcre.dylib" Class="DependencyModule">
                    <Platform Name="iOSSimulator">
                        <Overwrite>true</Overwrite>
                    </Platform>
                </DeployFile>
                <DeployFile LocalName="$(BDS)\Redist\osx32\libcgunwind.1.0.dylib" Class="DependencyModule">
                    <Platform Name="OSX32">
                        <Overwrite>true</Overwrite>
                    </Platform>
                </DeployFile>
                <DeployFile LocalName="C:\Users\Public\Documents\Embarcadero\Studio\23.0\Bpl\OrionHelpers.bpl" Configuration="Debug" Class="ProjectOutput">
                    <Platform Name="Win32">
                        <RemoteName>OrionHelpers.bpl</RemoteName>
                        <Overwrite>true</Overwrite>
                    </Platform>
                </DeployFile>
                <DeployClass Name="AdditionalDebugSymbols">
                    <Platform Name="OSX32">
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Win32">
                        <Operation>0</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="AndroidClasses">
                    <Platform Name="Android">
                        <RemoteDir>classes</RemoteDir>
                        <Operation>64</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>classes</RemoteDir>
                        <Operation>64</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="AndroidFileProvider">
                    <Platform Name="Android">
                        <RemoteDir>res\xml</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>res\xml</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="AndroidLibnativeArmeabiFile">
                    <Platform Name="Android">
                        <RemoteDir>library\lib\armeabi</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>library\lib\armeabi</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="AndroidLibnativeArmeabiv7aFile">
                    <Platform Name="Android64">
                        <RemoteDir>library\lib\armeabi-v7a</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="AndroidLibnativeMipsFile">
                    <Platform Name="Android">
                        <RemoteDir>library\lib\mips</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>library\lib\mips</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="AndroidServiceOutput">
                    <Platform Name="Android">
                        <RemoteDir>library\lib\armeabi-v7a</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>library\lib\arm64-v8a</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="AndroidServiceOutput_Android32">
                    <Platform Name="Android64">
                        <RemoteDir>library\lib\armeabi-v7a</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="AndroidSplashImageDef">
                    <Platform Name="Android">
                        <RemoteDir>res\drawable</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>res\drawable</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="AndroidSplashImageDefV21">
                    <Platform Name="Android">
                        <RemoteDir>res\drawable-anydpi-v21</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>res\drawable-anydpi-v21</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="AndroidSplashStyles">
                    <Platform Name="Android">
                        <RemoteDir>res\values</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>res\values</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="AndroidSplashStylesV21">
                    <Platform Name="Android">
                        <RemoteDir>res\values-v21</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>res\values-v21</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="AndroidSplashStylesV31">
                    <Platform Name="Android">
                        <RemoteDir>res\values-v31</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>res\values-v31</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="Android_AdaptiveIcon">
                    <Platform Name="Android">
                        <RemoteDir>res\drawable-anydpi-v26</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>res\drawable-anydpi-v26</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="Android_AdaptiveIconBackground">
                    <Platform Name="Android">
                        <RemoteDir>res\drawable</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>res\drawable</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="Android_AdaptiveIconForeground">
                    <Platform Name="Android">
                        <RemoteDir>res\drawable</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>res\drawable</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="Android_AdaptiveIconMonochrome">
                    <Platform Name="Android">
                        <RemoteDir>res\drawable</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>res\drawable</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="Android_AdaptiveIconV33">
                    <Platform Name="Android">
                        <RemoteDir>res\drawable-anydpi-v33</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>res\drawable-anydpi-v33</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="Android_Colors">
                    <Platform Name="Android">
                        <RemoteDir>res\values</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>res\values</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="Android_ColorsDark">
                    <Platform Name="Android">
                        <RemoteDir>res\values-night-v21</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>res\values-night-v21</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="Android_DefaultAppIcon">
                    <Platform Name="Android">
                        <RemoteDir>res\drawable</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>res\drawable</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="Android_LauncherIcon144">
                    <Platform Name="Android">
                        <RemoteDir>res\drawable-xxhdpi</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>res\drawable-xxhdpi</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="Android_LauncherIcon192">
                    <Platform Name="Android">
                        <RemoteDir>res\drawable-xxxhdpi</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>res\drawable-xxxhdpi</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="Android_LauncherIcon36">
                    <Platform Name="Android">
                        <RemoteDir>res\drawable-ldpi</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>res\drawable-ldpi</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="Android_LauncherIcon48">
                    <Platform Name="Android">
                        <RemoteDir>res\drawable-mdpi</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>res\drawable-mdpi</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="Android_LauncherIcon72">
                    <Platform Name="Android">
                        <RemoteDir>res\drawable-hdpi</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>res\drawable-hdpi</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="Android_LauncherIcon96">
                    <Platform Name="Android">
                        <RemoteDir>res\drawable-xhdpi</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>res\drawable-xhdpi</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="Android_NotificationIcon24">
                    <Platform Name="Android">
                        <RemoteDir>res\drawable-mdpi</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>res\drawable-mdpi</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="Android_NotificationIcon36">
                    <Platform Name="Android">
                        <RemoteDir>res\drawable-hdpi</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>res\drawable-hdpi</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="Android_NotificationIcon48">
                    <Platform Name="Android">
                        <RemoteDir>res\drawable-xhdpi</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>res\drawable-xhdpi</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="Android_NotificationIcon72">
                    <Platform Name="Android">
                        <RemoteDir>res\drawable-xxhdpi</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>res\drawable-xxhdpi</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="Android_NotificationIcon96">
                    <Platform Name="Android">
                        <RemoteDir>res\drawable-xxxhdpi</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>res\drawable-xxxhdpi</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="Android_SplashImage426">
                    <Platform Name="Android">
                        <RemoteDir>res\drawable-small</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>res\drawable-small</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="Android_SplashImage470">
                    <Platform Name="Android">
                        <RemoteDir>res\drawable-normal</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>res\drawable-normal</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="Android_SplashImage640">
                    <Platform Name="Android">
                        <RemoteDir>res\drawable-large</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>res\drawable-large</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="Android_SplashImage960">
                    <Platform Name="Android">
                        <RemoteDir>res\drawable-xlarge</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>res\drawable-xlarge</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="Android_Strings">
                    <Platform Name="Android">
                        <RemoteDir>res\values</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>res\values</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="Android_VectorizedNotificationIcon">
                    <Platform Name="Android">
                        <RemoteDir>res\drawable-anydpi-v24</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>res\drawable-anydpi-v24</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="Android_VectorizedSplash">
                    <Platform Name="Android">
                        <RemoteDir>res\drawable</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>res\drawable</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="Android_VectorizedSplashDark">
                    <Platform Name="Android">
                        <RemoteDir>res\drawable-night-anydpi-v21</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>res\drawable-night-anydpi-v21</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="Android_VectorizedSplashV31">
                    <Platform Name="Android">
                        <RemoteDir>res\drawable-anydpi-v31</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>res\drawable-anydpi-v31</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="Android_VectorizedSplashV31Dark">
                    <Platform Name="Android">
                        <RemoteDir>res\drawable-night-anydpi-v31</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>res\drawable-night-anydpi-v31</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="DebugSymbols">
                    <Platform Name="iOSSimulator">
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="OSX32">
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Win32">
                        <Operation>0</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="DependencyFramework">
                    <Platform Name="OSX32">
                        <Operation>1</Operation>
                        <Extensions>.framework</Extensions>
                    </Platform>
                    <Platform Name="OSX64">
                        <Operation>1</Operation>
                        <Extensions>.framework</Extensions>
                    </Platform>
                    <Platform Name="OSXARM64">
                        <Operation>1</Operation>
                        <Extensions>.framework</Extensions>
                    </Platform>
                    <Platform Name="Win32">
                        <Operation>0</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="DependencyModule">
                    <Platform Name="OSX32">
                        <Operation>1</Operation>
                        <Extensions>.dylib</Extensions>
                    </Platform>
                    <Platform Name="OSX64">
                        <Operation>1</Operation>
                        <Extensions>.dylib</Extensions>
                    </Platform>
                    <Platform Name="OSXARM64">
                        <Operation>1</Operation>
                        <Extensions>.dylib</Extensions>
                    </Platform>
                    <Platform Name="Win32">
                        <Operation>0</Operation>
                        <Extensions>.dll;.bpl</Extensions>
                    </Platform>
                </DeployClass>
                <DeployClass Required="true" Name="DependencyPackage">
                    <Platform Name="iOSDevice32">
                        <Operation>1</Operation>
                        <Extensions>.dylib</Extensions>
                    </Platform>
                    <Platform Name="iOSDevice64">
                        <Operation>1</Operation>
                        <Extensions>.dylib</Extensions>
                    </Platform>
                    <Platform Name="iOSSimARM64">
                        <Operation>1</Operation>
                        <Extensions>.dylib</Extensions>
                    </Platform>
                    <Platform Name="OSX32">
                        <Operation>1</Operation>
                        <Extensions>.dylib</Extensions>
                    </Platform>
                    <Platform Name="OSX64">
                        <Operation>1</Operation>
                        <Extensions>.dylib</Extensions>
                    </Platform>
                    <Platform Name="OSXARM64">
                        <Operation>1</Operation>
                        <Extensions>.dylib</Extensions>
                    </Platform>
                    <Platform Name="Win32">
                        <Operation>0</Operation>
                        <Extensions>.bpl</Extensions>
                    </Platform>
                </DeployClass>
                <DeployClass Name="File">
                    <Platform Name="Android">
                        <Operation>0</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <Operation>0</Operation>
                    </Platform>
                    <Platform Name="iOSDevice32">
                        <Operation>0</Operation>
                    </Platform>
                    <Platform Name="iOSDevice64">
                        <Operation>0</Operation>
                    </Platform>
                    <Platform Name="iOSSimARM64">
                        <Operation>0</Operation>
                    </Platform>
                    <Platform Name="OSX32">
                        <Operation>0</Operation>
                    </Platform>
                    <Platform Name="OSX64">
                        <Operation>0</Operation>
                    </Platform>
                    <Platform Name="OSXARM64">
                        <Operation>0</Operation>
                    </Platform>
                    <Platform Name="Win32">
                        <Operation>0</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="ProjectAndroidManifest">
                    <Platform Name="Android">
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="ProjectOSXDebug"/>
                <DeployClass Name="ProjectOSXEntitlements"/>
                <DeployClass Name="ProjectOSXInfoPList"/>
                <DeployClass Name="ProjectOSXResource">
                    <Platform Name="OSX32">
                        <RemoteDir>Contents\Resources</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="OSX64">
                        <RemoteDir>Contents\Resources</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="OSXARM64">
                        <RemoteDir>Contents\Resources</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Required="true" Name="ProjectOutput">
                    <Platform Name="Android">
                        <RemoteDir>library\lib\armeabi-v7a</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Android64">
                        <RemoteDir>library\lib\arm64-v8a</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="iOSDevice32">
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="iOSDevice64">
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="iOSSimARM64">
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Linux64">
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="OSX32">
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="OSX64">
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="OSXARM64">
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Win32">
                        <Operation>0</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="ProjectOutput_Android32">
                    <Platform Name="Android64">
                        <RemoteDir>library\lib\armeabi-v7a</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="ProjectUWPManifest">
                    <Platform Name="Win32">
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Win64">
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="ProjectiOSDeviceDebug">
                    <Platform Name="iOSDevice32">
                        <RemoteDir>..\$(PROJECTNAME).app.dSYM\Contents\Resources\DWARF</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="iOSDevice64">
                        <RemoteDir>..\$(PROJECTNAME).app.dSYM\Contents\Resources\DWARF</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="iOSSimARM64">
                        <RemoteDir>..\$(PROJECTNAME).app.dSYM\Contents\Resources\DWARF</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="ProjectiOSEntitlements"/>
                <DeployClass Name="ProjectiOSInfoPList"/>
                <DeployClass Name="ProjectiOSLaunchScreen"/>
                <DeployClass Name="ProjectiOSResource">
                    <Platform Name="iOSDevice32">
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="iOSDevice64">
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="iOSSimARM64">
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="UWP_DelphiLogo150">
                    <Platform Name="Win32">
                        <RemoteDir>Assets</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Win64">
                        <RemoteDir>Assets</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="UWP_DelphiLogo44">
                    <Platform Name="Win32">
                        <RemoteDir>Assets</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="Win64">
                        <RemoteDir>Assets</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="iOS_AppStore1024">
                    <Platform Name="iOSDevice64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\AppIcon.appiconset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="iOSSimARM64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\AppIcon.appiconset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="iPad_AppIcon152">
                    <Platform Name="iOSDevice64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\AppIcon.appiconset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="iOSSimARM64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\AppIcon.appiconset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="iPad_AppIcon167">
                    <Platform Name="iOSDevice64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\AppIcon.appiconset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="iOSSimARM64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\AppIcon.appiconset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="iPad_Launch2x">
                    <Platform Name="iOSDevice64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\LaunchScreenImage.imageset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="iOSSimARM64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\LaunchScreenImage.imageset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="iPad_LaunchDark2x">
                    <Platform Name="iOSDevice64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\LaunchScreenImage.imageset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="iOSSimARM64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\LaunchScreenImage.imageset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="iPad_Notification40">
                    <Platform Name="iOSDevice64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\AppIcon.appiconset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="iOSSimARM64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\AppIcon.appiconset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="iPad_Setting58">
                    <Platform Name="iOSDevice64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\AppIcon.appiconset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="iOSSimARM64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\AppIcon.appiconset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="iPad_SpotLight80">
                    <Platform Name="iOSDevice64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\AppIcon.appiconset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="iOSSimARM64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\AppIcon.appiconset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="iPhone_AppIcon120">
                    <Platform Name="iOSDevice64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\AppIcon.appiconset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="iOSSimARM64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\AppIcon.appiconset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="iPhone_AppIcon180">
                    <Platform Name="iOSDevice64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\AppIcon.appiconset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="iOSSimARM64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\AppIcon.appiconset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="iPhone_Launch2x">
                    <Platform Name="iOSDevice64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\LaunchScreenImage.imageset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="iOSSimARM64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\LaunchScreenImage.imageset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="iPhone_Launch3x">
                    <Platform Name="iOSDevice64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\LaunchScreenImage.imageset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="iOSSimARM64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\LaunchScreenImage.imageset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="iPhone_LaunchDark2x">
                    <Platform Name="iOSDevice64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\LaunchScreenImage.imageset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="iOSSimARM64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\LaunchScreenImage.imageset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="iPhone_LaunchDark3x">
                    <Platform Name="iOSDevice64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\LaunchScreenImage.imageset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="iOSSimARM64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\LaunchScreenImage.imageset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="iPhone_Notification40">
                    <Platform Name="iOSDevice64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\AppIcon.appiconset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="iOSSimARM64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\AppIcon.appiconset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="iPhone_Notification60">
                    <Platform Name="iOSDevice64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\AppIcon.appiconset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="iOSSimARM64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\AppIcon.appiconset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="iPhone_Setting58">
                    <Platform Name="iOSDevice64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\AppIcon.appiconset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="iOSSimARM64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\AppIcon.appiconset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="iPhone_Setting87">
                    <Platform Name="iOSDevice64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\AppIcon.appiconset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="iOSSimARM64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\AppIcon.appiconset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="iPhone_Spotlight120">
                    <Platform Name="iOSDevice64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\AppIcon.appiconset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="iOSSimARM64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\AppIcon.appiconset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <DeployClass Name="iPhone_Spotlight80">
                    <Platform Name="iOSDevice64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\AppIcon.appiconset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                    <Platform Name="iOSSimARM64">
                        <RemoteDir>..\$(PROJECTNAME).launchscreen\Assets\AppIcon.appiconset</RemoteDir>
                        <Operation>1</Operation>
                    </Platform>
                </DeployClass>
                <ProjectRoot Platform="Android" Name="$(PROJECTNAME)"/>
                <ProjectRoot Platform="Android64" Name="$(PROJECTNAME)"/>
                <ProjectRoot Platform="iOSDevice32" Name="$(PROJECTNAME).app"/>
                <ProjectRoot Platform="iOSDevice64" Name="$(PROJECTNAME).app"/>
                <ProjectRoot Platform="iOSSimARM64" Name="$(PROJECTNAME).app"/>
                <ProjectRoot Platform="Linux64" Name="$(PROJECTNAME)"/>
                <ProjectRoot Platform="OSX32" Name="$(PROJECTNAME)"/>
                <ProjectRoot Platform="OSX64" Name="$(PROJECTNAME)"/>
                <ProjectRoot Platform="OSXARM64" Name="$(PROJECTNAME)"/>
                <ProjectRoot Platform="Win32" Name="$(PROJECTNAME)"/>
                <ProjectRoot Platform="Win64" Name="$(PROJECTNAME)"/>
            </Deployment>
            <Platforms>
                <Platform value="Android">False</Platform>
                <Platform value="Android64">False</Platform>
                <Platform value="iOSDevice64">False</Platform>
                <Platform value="iOSSimARM64">False</Platform>
                <Platform value="Linux64">False</Platform>
                <Platform value="Win32">True</Platform>
                <Platform value="Win64">False</Platform>
            </Platforms>
        </BorlandProject>
        <ProjectFileVersion>12</ProjectFileVersion>
    </ProjectExtensions>
    <Import Project="$(BDS)\Bin\CodeGear.Delphi.Targets" Condition="Exists('$(BDS)\Bin\CodeGear.Delphi.Targets')"/>
    <Import Project="$(APPDATA)\Embarcadero\$(BDSAPPDATABASEDIR)\$(PRODUCTVERSION)\UserTools.proj" Condition="Exists('$(APPDATA)\Embarcadero\$(BDSAPPDATABASEDIR)\$(PRODUCTVERSION)\UserTools.proj')"/>
    <Import Project="$(MSBuildProjectName).deployproj" Condition="Exists('$(MSBuildProjectName).deployproj')"/>
</Project>
