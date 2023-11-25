#include QMK_KEYBOARD_H

enum layer_names {
    _BASE,
    _COLEMAK,
    _QWERTY,
    _NUM,
    _CODE,
    _NAV,
    _FN,
};

enum custom_keycodes {
  TG_LANG = SAFE_RANGE,
};

#define HYP_SLSH HYPR_T(KC_SLSH)  // Hyper on hold, `/` on tap
#define HYP_Z    HYPR_T(KC_Z)     // Hyper on hold, `z` on tap
#define SPC_NUM  LT(_NUM, KC_SPC) // Space on tap, Num layer on hold
#define TAB_NAV  LT(_NAV, KC_TAB) // Tab on tap, Nav layer on hold
#define ESC_CODE LT(_CODE, KC_ESC) // Esc on tap, Code layer on hold
#define WORD_R   LOPT(KC_RGHT) // Move right one word
#define WORD_L   LOPT(KC_LEFT) // Move left one word
#define DEL_W    LOPT(KC_BSPC) // Delete word to the left


const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
  [_BASE] = LAYOUT_all(
    KC_TAB,    KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,    KC_Y,    KC_U,     KC_I,    KC_O,    KC_P,     KC_LBRC, KC_RBRC,KC_BSLS,          TG(_COLEMAK),
    KC_CAPS,   KC_A,    KC_S,    KC_D,    KC_F,    KC_G,    KC_H,    KC_J,     KC_K,    KC_L,    KC_SCLN,  KC_QUOT, KC_ENT,                   KC_NO,
    KC_LSFT,   HYP_Z,   KC_X,    KC_C,    KC_V,    KC_B,    KC_N,    KC_M,     KC_COMM, KC_DOT,  HYP_SLSH, KC_RSFT,                  KC_UP,   MO(_FN),
    KC_LCTL,   KC_LOPT, KC_LCMD,          SPC_NUM,          KC_SPC,            KC_HYPR, KC_NO,   KC_ROPT,                   KC_LEFT, KC_DOWN, KC_RIGHT
  ),

  [_COLEMAK] = LAYOUT_all(
    TAB_NAV,   KC_Q,    KC_W,    KC_F,    KC_P,    KC_B,    KC_J,    KC_L,     KC_U,    KC_Y,    KC_SCLN,  KC_BSPC, DEL_W,  KC_BSLS,          TG(_COLEMAK),
    ESC_CODE,  KC_A,    KC_R,    KC_S,    KC_T,    KC_G,    KC_M,    KC_N,     KC_E,    KC_I,    KC_O,     KC_QUOT, KC_ENT,                   KC_NO,
    KC_LSFT,   KC_Z,    KC_X,    KC_C,    KC_D,    KC_V,    KC_K,    KC_H,     KC_COMM, KC_DOT,  KC_SLSH,  KC_RSFT,                  KC_UP,   MO(_FN),
    KC_LCTL,   KC_LOPT, KC_LCMD,          SPC_NUM,          KC_SPC,            KC_HYPR, KC_NO,   TG_LANG,                   KC_LEFT, KC_DOWN, KC_RIGHT
  ),

  [_QWERTY] = LAYOUT_all(
    TAB_NAV,   KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,    KC_Y,    KC_U,     KC_I,    KC_O,    KC_P,     KC_BSPC, DEL_W,  KC_BSLS,          KC_NO,
    ESC_CODE,  KC_A,    KC_S,    KC_D,    KC_F,    KC_G,    KC_H,    KC_J,     KC_K,    KC_L,    KC_SCLN,  KC_QUOT, KC_ENT,                   KC_NO,
    KC_LSFT,   KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,    KC_N,    KC_M,     KC_COMM, KC_DOT,  KC_SLSH,  KC_RSFT,                  KC_UP,   MO(_FN),
    KC_LCTL,   KC_LOPT, KC_LCMD,          SPC_NUM,          KC_SPC,            KC_HYPR, KC_NO,   TG_LANG,                   KC_LEFT, KC_DOWN, KC_RIGHT
  ),

  [_CODE] = LAYOUT_all(
    KC_NO,     C(KC_Q), C(KC_W), C(KC_F), C(KC_P), C(KC_B), KC_NO,   KC_LCBR,  KC_RCBR, KC_PLUS, KC_COLN,  KC_BSPC, DEL_W,  KC_BSLS,          KC_NO,
    KC_TRNS,   C(KC_A), C(KC_R), C(KC_S), C(KC_T), C(KC_G), KC_UNDS, KC_LPRN,  KC_RPRN, KC_EQL,  KC_MINUS, KC_DQUO, KC_ENT,                   KC_NO,
    KC_NO,     C(KC_Z), C(KC_X), C(KC_C), C(KC_D), C(KC_V), KC_NO,   KC_LBRC,  KC_RBRC, KC_LT,   KC_GT,    KC_QUES,                  KC_UP,   KC_NO,  
    KC_NO,     KC_NO,   KC_LCMD,          KC_NO,            KC_NO,             KC_NO,   KC_NO,   KC_NO,                     KC_LEFT, KC_DOWN, KC_RIGHT
  ),

  [_NAV] = LAYOUT_all(
    KC_TRNS,   KC_LSFT, WORD_R,  KC_NO,   KC_NO,   WORD_L,  KC_NO,   KC_NO,    KC_NO,   KC_NO,   KC_NO,    KC_BSPC, DEL_W,  KC_BSLS,          KC_NO,
    KC_NO,     KC_LCTL, KC_LOPT, KC_LCMD, KC_NO,   KC_NO,   KC_LEFT, KC_DOWN,  KC_UP,   KC_RGHT, KC_TILD,  KC_GRV,  KC_ENT,                   KC_NO,
    KC_NO,     G(KC_Z), G(KC_X), G(KC_C), G(KC_V), KC_NO,   KC_NO,   KC_NO,    KC_NO,   KC_NO,   KC_PIPE,  KC_BSLS,                  KC_UP,   KC_NO,  
    KC_NO,     KC_NO,   KC_NO,            KC_NO,            KC_NO,             KC_NO,   KC_NO,   KC_NO,                     KC_LEFT, KC_DOWN, KC_RIGHT
  ),
  
  [_NUM] = LAYOUT_all(
    TAB_NAV,   KC_1,    KC_2,    KC_3,    KC_4,    KC_5,    KC_6,    KC_7,     KC_8,    KC_9,    KC_0,     KC_BSPC, DEL_W,  KC_BSLS,          KC_NO,
    KC_TRNS,   KC_EXLM, KC_AT,   KC_HASH, KC_DLR,  KC_NO,   KC_NO,   KC_4,     KC_5,    KC_6,    KC_NO,    KC_NO,   KC_ENT,                   KC_NO,
    KC_NO,     KC_PERC, KC_CIRC, KC_AMPR, KC_ASTR, KC_NO,   KC_1,    KC_2,     KC_3,    KC_DOT,  HYP_SLSH, KC_RSFT,                  KC_UP,   KC_NO,  
    KC_NO,     KC_NO,   KC_NO,            KC_TRNS,          KC_0,              KC_NO,   KC_NO,   KC_NO,                     KC_LEFT, KC_DOWN, KC_RIGHT
  ),

  [_FN] = LAYOUT_all(
    QK_BOOT,   KC_BRID, KC_BRIU, KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,    KC_NO,   KC_NO,   KC_NO,    KC_NO,   KC_NO,  KC_NO,            KC_SLEP,
    KC_NO,     KC_MPRV, KC_MPLY, KC_MNXT, KC_NO,   KC_NO,   KC_NO,   KC_NO,    KC_NO,   KC_NO,   KC_NO,    KC_NO,   KC_NO,                    KC_NO,
    KC_NO,     KC_VOLD, KC_MUTE, KC_VOLU, KC_NO,   KC_NO,   KC_NO,   KC_NO,    KC_NO,   KC_NO,   KC_NO,    KC_NO,                    KC_UP,   KC_TRNS,
    KC_NO,     KC_NO,   KC_NO,            KC_NO,            RGB_TOG,           KC_NO,   KC_NO,   KC_NO,                     KC_LEFT, KC_DOWN, KC_RIGHT
  ),
};

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {
    case TG_LANG:
      if (record->event.pressed) {
        layer_invert(_QWERTY);
        tap_code(KC_CAPS);
      }
      break;
  }
  return true;
};

uint16_t get_tapping_term(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {
    case LT(_CODE, KC_ESC):
      return 10;  // in ms
    case LT(_NAV, KC_TAB):
      return 10; // in ms
    default:
      return 150;
  }
};

