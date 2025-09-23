/* Copyright 2024 ai03 Design Studio */
/* SPDX-License-Identifier: GPL-2.0-or-later */

#include QMK_KEYBOARD_H

enum layer_names {
    _BASE,
    _SYM,
    _NUM,
    _NIL,
    _FN
};

#define NUM_SPC  LT(_NUM,KC_SPC) // Number layer on hold, `Space` on tap
#define SYM_A    LT(_SYM,KC_A)   // Symbol layer on hold, `A` on tap
#define HYP_Z    RCMD_T(KC_Z)    // Hyper on hold, `z` on tap (karabiner)
#define ONEPW    LCMD(KC_BSLS)   // 1Password
#define KK_COLN  S(KC_P)         // Karabiner colon

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [_BASE] = LAYOUT(
        QK_GESC, KC_1,    KC_2,    KC_3,    KC_4,    KC_5,    XXXXXXX, /**/  MO(_FN), KC_6,    KC_7,    KC_8,    KC_9,    KC_0,    ONEPW,
        KC_TAB,  KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,    XXXXXXX, /**/  XXXXXXX, KC_Y,    KC_U,    KC_I,    KC_O,    KC_P,    KC_BSPC,
        KC_CAPS, KC_A,    KC_S,    KC_D,    KC_F,    KC_G,    XXXXXXX, /**/  XXXXXXX, KC_H,    KC_J,    KC_K,    KC_L,    KC_SCLN, KC_QUOT,
        KC_LSFT, KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,    XXXXXXX, /**/  KC_B,    KC_N,    KC_M,    KC_COMM, KC_DOT,  KC_SLSH, KC_RSFT,
                                   KC_LALT, KC_LCMD, MO(_SYM),NUM_SPC, /**/  KC_ENT,  KC_SPC,  KC_HYPR, KC_MEH
    ),
    [_SYM] = LAYOUT(
        XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, /**/  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
        KC_TAB,  KC_GRV,  KC_TILD, KC_BSLS, KC_PIPE, XXXXXXX, XXXXXXX, /**/  XXXXXXX, KC_GRV,  KC_LCBR, KC_RCBR, KC_PLUS, KK_COLN, KC_BSPC,
        KC_CAPS, KC_EXLM, KC_AT,   KC_HASH, KC_DLR,  XXXXXXX, XXXXXXX, /**/  XXXXXXX, KC_UNDS, KC_LPRN, KC_RPRN, KC_EQL,  KC_MINS, KC_DQT,
        KC_LSFT, KC_PERC, KC_CIRC, KC_AMPR, KC_ASTR, XXXXXXX, XXXXXXX, /**/  XXXXXXX, KC_LBRC, KC_RBRC, KC_LT,   KC_GT,   KC_QUES, KC_RSFT,
                                   XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, /**/  KC_ENT,  KC_SPC,  XXXXXXX, XXXXXXX
    ),
    [_NUM] = LAYOUT(
        XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, /**/  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
        _______, XXXXXXX, KC_PLUS, KC_MINS, KC_SLSH, KC_ASTR, XXXXXXX, /**/  XXXXXXX, XXXXXXX, KC_7,    KC_8,    KC_9,    KC_PLUS, XXXXXXX,
        _______, KC_EXLM, KC_AT,   KC_HASH, KC_DLR,  KC_EQL,  XXXXXXX, /**/  XXXXXXX, KC_EQL,  KC_4,    KC_5,    KC_6,    KC_MINS, KC_ASTR,
        XXXXXXX, KC_PERC, KC_CIRC, KC_AMPR, KC_ASTR, XXXXXXX, XXXXXXX, /**/  XXXXXXX, KC_0,    KC_1,    KC_2,    KC_3,    KC_SLSH, KC_ASTR,
                                   _______, _______, XXXXXXX, XXXXXXX, /**/  KC_ENT,  KC_SPC,  KC_0,    XXXXXXX
    ),
    [_NIL] = LAYOUT(
        XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, /**/  MO(_FN), XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
        XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, /**/  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
        XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, /**/  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
        XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, /**/  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
                                   XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, /**/  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX
    ),
    [_FN] = LAYOUT(
        XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, QK_BOOT, /**/  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
        XXXXXXX, KC_BRID, KC_BRIU, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, /**/  TG(_NIL),XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
        XXXXXXX, KC_MPRV, KC_MNXT, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, /**/  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
        XXXXXXX, KC_VOLD, KC_MUTE, KC_VOLU, XXXXXXX, XXXXXXX, XXXXXXX, /**/  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
                                   XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, /**/  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX
    )
};

uint16_t get_tapping_term(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
        case HYP_Z:
        case SYM_A:
            return 30; // in ms
        default:
            return 100;
    }
}
