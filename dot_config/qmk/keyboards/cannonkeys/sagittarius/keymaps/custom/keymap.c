#include QMK_KEYBOARD_H


// Each layer gets a name for readability, which is then used in the keymap matrix below.
// The underscores don't mean anything - you can have a layer called STUFF or any other name.
// Layer names don't all need to be of the same length, obviously, and you can also skip them
// entirely and just use numbers.
enum layer_names {
    _QWERTY,
    _NUM,
    _FN,
    _TEMPLATE,
};
enum custom_keycodes {
    TG_LANG = SAFE_RANGE,
};


const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [_QWERTY] = LAYOUT_default(
        KC_NO,   QK_GESC,                KC_1, KC_2, KC_3, KC_4, KC_5, KC_6, KC_7,   KC_8, KC_9,    KC_0,   KC_MINS,         KC_EQL,  KC_NO,   KC_NO,
        KC_NO,   KC_TAB,                 KC_Q, KC_W, KC_E, KC_R, KC_T,       KC_Y,   KC_U, KC_I,    KC_O,   KC_P,            KC_LBRC, KC_RBRC, KC_BSLS,
        KC_NO,   KC_CAPS,                KC_A, KC_S, KC_D, KC_F, KC_G,       KC_H,   KC_J, KC_K,    KC_L,   KC_SCLN,         KC_QUOT, KC_NO,   KC_ENT, KC_NO,
        MO(_FN), KC_LSFT, KC_NO,  HYPR_T(KC_Z),KC_X, KC_C, KC_V, KC_B,       KC_N,   KC_M, KC_COMM, KC_DOT, HYPR_T(KC_SLSH), KC_RSFT, KC_RSFT, MO(_FN),
                 KC_LCTL, KC_LALT,                  KC_LGUI, MO(_NUM),       KC_SPC, KC_NO,         KC_HYPR,KC_NO,   TG_LANG
    ),

    [_NUM] = LAYOUT_default(
        KC_NO,   KC_NO,        KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5, KC_F6, KC_F7, KC_F8, KC_F9, KC_F10,  KC_NO,   KC_NO, KC_NO, KC_NO,
        KC_NO,   KC_NO,        KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,        KC_7,  KC_8,  KC_9,  KC_PLUS, KC_NO,   KC_NO, KC_NO, KC_NO,
        KC_NO,   KC_NO,        KC_EXLM, KC_AT,   KC_HASH, KC_DLR,  KC_NO,        KC_4,  KC_5,  KC_6,  KC_MINS, KC_MINS, KC_NO, KC_NO, KC_NO, KC_NO,
        KC_NO,   KC_NO, KC_NO, KC_PERC, KC_CIRC, KC_AMPR, KC_ASTR, KC_NO,        KC_1,  KC_2,  KC_3,  KC_DOT,  KC_SLSH, KC_NO, KC_NO, KC_NO,
                 KC_NO, KC_NO,                            KC_NO, KC_TRNS,        KC_0,  KC_NO,        KC_NO,   KC_NO,   KC_NO
    ),

    [_FN] = LAYOUT_default(
        QK_BOOT, KC_NO,        KC_BRID, KC_BRIU, KC_NO,   KC_NO,    KC_NO, KC_NO, KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO, KC_NO, KC_NO,
        KC_NO,   KC_NO,        KC_MPRV, KC_MPLY, KC_MNXT, KC_NO,    KC_NO,        RGB_VAD, RGB_VAI, RGB_M_P, RGB_M_B, RGB_M_R, KC_NO, KC_NO, KC_NO,
        KC_NO,   KC_NO,        KC_VOLD, KC_MUTE, KC_VOLU, KC_NO,    KC_NO,        RGB_HUD, RGB_HUI, RGB_M_SW,RGB_M_SN,RGB_M_K, KC_NO, KC_NO, RGB_MOD, KC_NO,
        KC_TRNS, KC_NO, KC_NO, KC_NO,   KC_NO,   KC_NO,   KC_NO,    KC_NO,        RGB_SAD, RGB_SAI, RGB_M_X, RGB_M_G, KC_NO,   KC_NO, KC_NO, KC_TRNS,
                 KC_NO, KC_NO,                            KC_NO,    KC_NO,        RGB_TOG, KC_NO,            KC_NO,   KC_NO,   KC_NO
    ),

	[_TEMPLATE] = LAYOUT_default(
		KC_NO,    KC_NO,        KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, // 16
        KC_NO,    KC_NO,        KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,        KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, // 15
        KC_NO,    KC_NO,        KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,        KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, // 16
        KC_NO,    KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,        KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, // 16
                  KC_NO, KC_NO,                      KC_NO, KC_NO,        KC_NO, KC_NO,        KC_NO, KC_NO, KC_NO // 9
    ),
};

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
        case TG_LANG:
            if (record->event.pressed) {
                // when keycode TG_LANG is pressed
                tap_code(KC_RALT);
            }
            break;
    }
    return true;
};
