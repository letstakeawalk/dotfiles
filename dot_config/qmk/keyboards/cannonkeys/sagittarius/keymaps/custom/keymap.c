#include QMK_KEYBOARD_H

enum layer_names {
    _BASE,
    _NUM,
    _FN,
};

#define TAB_NAV  KC_TAB           // Navigation layer (karabiner)
#define ESC_CODE KC_CAPS          // Coding layer (karabiner)
#define HYP_Z    RCMD_T(KC_Z)     // Hyper on hold, `z` on tap
#define OPT_BSP  LOPT(KC_BSPC)    // Option + Backspace
// #define MO_NUM  KC_F15

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [_BASE] = LAYOUT_default(
        KC_NO,   QK_GESC,         KC_1,    KC_2,    KC_3,    KC_4,    KC_5,  KC_6,  KC_7,    KC_8,    KC_9,    KC_0,    KC_MINS, KC_EQL,  KC_NO,   KC_NO,
        KC_NO,   TAB_NAV,         KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,         KC_Y,    KC_U,    KC_I,    KC_O,    KC_P,    KC_BSPC, OPT_BSP, KC_BSLS,
        KC_NO,   ESC_CODE,        KC_A,    KC_S,    KC_D,    KC_F,    KC_G,         KC_H,    KC_J,    KC_K,    KC_L,    KC_SCLN, KC_QUOT, KC_NO,   KC_ENT,  KC_NO,
        KC_NO,   KC_LSFT, KC_NO,  HYP_Z,   KC_X,    KC_C,    KC_V,    KC_B,         KC_N,    KC_M,    KC_COMM, KC_DOT,  KC_SLSH, KC_RSFT, KC_NO,   MO(_FN),
                 KC_LCTL, KC_LOPT,                        KC_LCMD, MO(_NUM),        KC_SPC,  KC_NO,                     KC_HYPR, KC_NO,   KC_ROPT
    ),

    [_NUM] = LAYOUT_default(
        KC_NO,   KC_NO,           KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5, KC_F6, KC_F7,   KC_F8,   KC_F9,   KC_F10,  KC_NO,   KC_NO,   KC_NO,   KC_NO,
        KC_NO,   KC_NO,           KC_1,    KC_2,    KC_3,    KC_4,    KC_5,         KC_6,    KC_7,    KC_8,    KC_9,    KC_0,    KC_TRNS, KC_TRNS, KC_NO,
        KC_NO,   KC_NO,           KC_EXLM, KC_AT,   KC_HASH, KC_DLR,  KC_NO,        KC_NO,   KC_4,    KC_5,    KC_6,    KC_NO,   KC_NO,   KC_NO,   KC_ENT,  KC_NO,
        KC_NO,   KC_NO,  KC_NO,   KC_PERC, KC_CIRC, KC_AMPR, KC_ASTR, KC_NO,        KC_NO,   KC_1,    KC_2,    KC_3,    KC_NO,   KC_NO,   KC_NO,   KC_NO,
                 KC_NO,  KC_NO,                              KC_NO, KC_TRNS,        KC_0,    KC_NO,                              KC_NO,   KC_NO,   KC_NO
    ),

    [_FN] = LAYOUT_default(
        QK_BOOT, KC_NO,           KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO, KC_NO, KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_SLEP,
        KC_NO,   KC_NO,           KC_BRID, KC_BRIU, KC_NO,   KC_NO,   KC_NO,        RGB_VAD, RGB_VAI, RGB_M_P, RGB_M_B, RGB_M_R, KC_NO,   KC_NO,   KC_NO,
        KC_NO,   KC_NO,           KC_MPRV, KC_MPLY, KC_MNXT, KC_NO,   KC_NO,        RGB_HUD, RGB_HUI, RGB_M_SW,RGB_M_SN,RGB_M_K, KC_NO,   KC_NO,   RGB_MOD, KC_NO,
        KC_NO,   KC_NO,  KC_NO,   KC_VOLD, KC_MUTE, KC_VOLU, KC_NO,   KC_NO,        RGB_SAD, RGB_SAI, RGB_M_X, RGB_M_G, KC_NO,   KC_NO,   KC_NO,   KC_TRNS,
                 KC_NO,  KC_NO,                              KC_NO,   KC_NO,        RGB_TOG, KC_NO,                              KC_NO,   KC_NO,   KC_NO
    ),
};

uint16_t get_tapping_term(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
        case RCMD_T(KC_Z):
            return 30; // in ms
        default:
            return 100;
    }
};
