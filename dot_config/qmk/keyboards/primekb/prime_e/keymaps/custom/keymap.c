#include QMK_KEYBOARD_H

// Toggle between Colemak-dhm and qwerty, then register CAPSLOCK to change language.
enum custom_keycodes {
  TG_LANG = SAFE_RANGE,
};

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {
    case TG_LANG:
      if (record->event.pressed) {
        layer_invert(1);
        tap_code(KC_CAPS);
      }
      break;
  }
  return true;
};

uint16_t get_tapping_term(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {
    case LT(2, KC_ESC):
      /* return 72;  // in ms */
      /* return 70;  // in ms */
      /* return 65;  // in ms */
      return 20;  // in ms
    case LT(3, KC_TAB):
      return 150; // in ms
    default:
      return 150;
  }
};

bool get_retro_tapping(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {
    case LT(2, KC_SPACE):
      return true;
    case LT(3, KC_ESC):
      return false;
    case LT(4, KC_TAB):
      return false;
    default:
      return false;
  }
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    // Colemak-dhm
    LAYOUT(
    LT(4, KC_TAB),  KC_Q,     KC_W,     KC_F,     KC_P,     KC_B,             KC_J,     KC_L,     KC_U,    KC_Y,      KC_SCLN,      KC_BSPC,   A(KC_BSPC),
    MO(3),          KC_A,     KC_R,     KC_S,     KC_T,     KC_G,             KC_M,     KC_N,     KC_E,    KC_I,      KC_O,         KC_ENT,
    KC_LSFT,        KC_Z,     KC_X,     KC_C,     KC_D,     KC_V,             KC_QUOT,  KC_K,     KC_H,    KC_COMM,   KC_DOT,       KC_SLSH,   KC_RSFT,
    KC_LCTL,        KC_LALT,                      KC_LCMD,  LT(2, KC_SPACE),  KC_SPACE, KC_RCMD,                      TG_LANG,      KC_CLCK
    ),

    // Qwerty
    LAYOUT(
    KC_TRNS,        KC_Q,     KC_W,     KC_E,     KC_R,     KC_T,             KC_Y,     KC_U,     KC_I,    KC_O,      KC_P,         KC_TRNS,   KC_TRNS,
    KC_TRNS,        KC_A,     KC_S,     KC_D,     KC_F,     KC_G,             KC_H,     KC_J,     KC_K,    KC_L,      KC_SCLN,      KC_TRNS,
    KC_TRNS,        KC_Z,     KC_X,     KC_C,     KC_V,     KC_B,             KC_B,     KC_N,     KC_M,    KC_COMM,   KC_DOT,       KC_TRNS,   KC_TRNS,
    KC_TRNS,        KC_TRNS,                      KC_TRNS,  KC_TRNS,          KC_TRNS,  KC_TRNS,                      KC_TRNS,      KC_TRNS
    ),

    // Number, Symbols
    LAYOUT(
    KC_TRNS,        KC_1,     KC_2,     KC_3,     KC_4,     KC_5,             KC_6,     KC_7,     KC_8,    KC_9,      KC_0,         KC_TRNS,   KC_TRNS,
    KC_TRNS,        KC_EXLM,  KC_AT,    KC_HASH,  KC_DLR,   KC_NO,            KC_MINUS, KC_4,     KC_5,    KC_6,      KC_PLUS,      KC_TRNS,
    KC_TRNS,        KC_PERC,  KC_CIRC,  KC_AMPR,  KC_ASTR,  KC_NO,            KC_0,     KC_1,     KC_2,    KC_3,      KC_DOT,       KC_SLSH,   KC_NO,
    KC_TRNS,        KC_TRNS,                      KC_TRNS,  KC_NO,            KC_0,     KC_TRNS,                      KC_NO,        KC_NO
    ),

    // Symbols for coding.
    LAYOUT(
    KC_TRNS,        C(KC_Q),  C(KC_W),  C(KC_F),  C(KC_P),  C(KC_B),          KC_NO,    KC_LCBR,  KC_RCBR, KC_MINUS,  KC_COLON,     KC_TRNS,   KC_TRNS,
    KC_TRNS,        C(KC_A),  C(KC_R),  C(KC_S),  C(KC_T),  KC_ESC,           KC_UNDS,  KC_LPRN,  KC_RPRN, KC_EQL,    KC_PLUS,      KC_DQUO,
    KC_TRNS,        C(KC_Z),  C(KC_X),  C(KC_C),  C(KC_D),  C(KC_V),          KC_QUOT,  KC_LBRC,  KC_RBRC, KC_LABK,   KC_RABK,      KC_QUES,   KC_NO,
    KC_TRNS,        KC_TRNS,                      KC_TRNS,  KC_TRNS,          KC_TRNS,  KC_TRNS,                      KC_NO,        KC_NO
    ),

    // Navigation
    LAYOUT(
    KC_TRNS,        KC_LSFT,  A(KC_RGHT),KC_NO,   KC_NO,    A(KC_LEFT),       KC_HOME,  KC_PGDN,  KC_PGUP, KC_END,    KC_NO,        KC_NO,     KC_NO,
    KC_TRNS,        KC_LCTL,  KC_LALT,  KC_RCMD,  KC_NO,    KC_ESC,           KC_LEFT,  KC_DOWN,  KC_UP,   KC_RGHT,   KC_TILDE,     KC_GRAVE,
    KC_TRNS,        G(KC_Z),  G(KC_X),  G(KC_C),  G(KC_V),  KC_NO,            KC_MPRV,  KC_VOLD,  KC_VOLU, KC_MNXT,   KC_PIPE,      KC_BSLASH, KC_NO,
    KC_TRNS,        KC_TRNS,                      KC_TRNS,  KC_TRNS,          KC_MPLY,  KC_TRNS,                      KC_NO,        RESET
    )
};

void matrix_init_user(void) {
  // set CapsLock LED to output and low
  setPinOutput(B1);
  writePinLow(B1);
  // set NumLock LED to output and low
  setPinOutput(B2);
  writePinLow(B2);
  // set ScrollLock LED to output and low
  setPinOutput(B3);
  writePinLow(B3);
}

void matrix_scan_user(void) {

}


void led_set_user(uint8_t usb_led) {
  if (IS_LED_ON(usb_led, USB_LED_NUM_LOCK)) {
    writePinHigh(B2);
  } else {
    writePinLow(B2);
  }
  if (IS_LED_ON(usb_led, USB_LED_CAPS_LOCK)) {
    writePinHigh(B1);
  } else {
    writePinLow(B1);
  }
/*
  if (IS_LED_ON(usb_led, USB_LED_SCROLL_LOCK)) {
    writePinHigh(B3);
  } else {
    writePinLow(B3);
  }*/

}

//function for layer indicator LED
layer_state_t layer_state_set_user(layer_state_t state)
{
    if (get_highest_layer(state) == 1) {
    writePinHigh(B3);
	} else {
		writePinLow(B3);
    }
    return state;
}
