#!/bin/bash
CURRENT_ROOT=`pwd`
# Remove all old sources
rm -rf src res
mkdir src res
git clone --branch=master git@github.com:facebook/facebook-android-sdk.git workdir
cd workdir/facebook/
cp -r res/* "${CURRENT_ROOT}/res"
cp -r src/* "${CURRENT_ROOT}/src"
cd "${CURRENT_ROOT}/src"
find . -type f -exec sed -i \
  -e 's/com.facebook.android.R/org.holoeverywhere.addon.facebook.R/' \
  -e 's/android.app.Activity/org.holoeverywhere.app.Activity/' \
  -e 's/android.support.v4.app.FragmentActivity/org.holoeverywhere.app.Activity/' \
  -e 's/android.support.v4.app.Fragment/org.holoeverywhere.app.Fragment/' \
  -e 's/android.app.Dialog/org.holoeverywhere.app.Dialog/' \
  -e 's/android.app.AlertDialog/org.holoeverywhere.app.AlertDialog/' \
  -e 's/android.app.ProgressDialog/org.holoeverywhere.app.ProgressDialog/' \
  -e 's/android.widget.Button/org.holoeverywhere.widget.Button/' \
  -e 's/android.widget.EditText/org.holoeverywhere.widget.EditText/' \
  -e 's/android.widget.ListView/org.holoeverywhere.widget.ListView/' \
  -e 's/android.widget.FrameLayout/org.holoeverywhere.widget.FrameLayout/' \
  -e 's/android.widget.LinearLayout/org.holoeverywhere.widget.LinearLayout/' \
  -e 's/android.view.LayoutInflater/org.holoeverywhere.LayoutInflater/' \
  -e 's/android.content.SharedPreferences/org.holoeverywhere.preference.SharedPreferences/' \
  -e 's/this.getActivity()/getSupportActivity()/' \
  -e 's/fragment.getActivity()/fragment.getSupportActivity()/' \
  -e 's/LayoutParams.FILL_PARENT/LayoutParams.MATCH_PARENT/' \
  -e 's/context.getSharedPreferences(/org.holoeverywhere.preference.PreferenceManager.wrap(context, /' \
  "{}" \;
echo "package com.facebook.android;

public final class R {
	public static final class drawable {
		public static final int com_facebook_close = org.holoeverywhere.addon.facebook.R.drawable.com_facebook_close;
	}
	public static final class string {
		public static final int com_facebook_loading = org.holoeverywhere.addon.facebook.R.string.com_facebook_loading;
	}
}" > com/facebook/android/R.java
echo "package com.facebook.android;

public final class BuildConfig {
    public final static boolean DEBUG = org.holoeverywhere.addon.facebook.BuildConfig.DEBUG;
}" > com/facebook/android/BuildConfig.java
cd ${CURRENT_ROOT}
rm -rf workdir
