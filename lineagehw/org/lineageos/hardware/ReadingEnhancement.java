 
/*
 * Copyright (C) 2018 The LineageOS Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.lineageos.hardware;

import org.lineageos.hardware.DisplayColorCalibration;
import org.lineageos.internal.util.FileUtils;

/**
 * Reader mode
 */
public class ReadingEnhancement {

    private static final String TAG = "ReadingEnhancement";

    private static final String COLOR_FILE = "/sys/devices/platform/host1x/tegradc.0/color_filter";

    private static final String MATRIX_GRAYSCALE = "54 182 18 54 182 18 54 182 18";
    private static final String MATRIX_RESTORE = "%s 0 0 0 %s 0 0 0 %s";

    private static boolean sEnabled;
    private static String sRestoreColors;

    static String getRestoreColors() {
        return sRestoreColors;
    }

    static void setRestoreColors(String colors) {
        sRestoreColors = colors;
    }

    /**
     * Whether device supports Reader Mode
     *
     * @return boolean Supported devices must return always true
     */
    public static boolean isSupported() {
        boolean supported = true;

        if (!FileUtils.isFileReadable(COLOR_FILE) || !FileUtils.isFileWritable(COLOR_FILE))
            supported = false;

        return supported;
    }

    /**
     * This method return the current activation status of Reader Mode
     *
     * @return boolean Must be false when Reader Mode is not supported or not activated,
     * or the operation failed while reading the status; true in any other case.
     */
    public static boolean isEnabled() {
        return sEnabled;
    }

    /**
     * This method allows to setup Reader Mode
     *
     * @param status The new Reader Mode status
     * @return boolean Must be false if Reader Mode is not supported or the operation
     * failed; true in any other case.
     */
    public static boolean setEnabled(boolean status) {
        sRestoreColors = DisplayColorCalibration.getCurColors();
        sEnabled = status;

        if (status) {
            FileUtils.writeLine(COLOR_FILE, MATRIX_GRAYSCALE);
        } else {
            String[] rgb = sRestoreColors.split(" ");
            FileUtils.writeLine(COLOR_FILE, String.format(MATRIX_RESTORE, rgb[0], rgb[1], rgb[2]));
        }

        return true;
    }
}
 
