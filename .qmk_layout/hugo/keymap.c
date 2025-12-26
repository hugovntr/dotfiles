#include "hugo.h"

enum layer_number {
  _BASE = 0,
  _LOWER,
  _RAISE,
  _FN,
  _ADJUST,
};
#ifdef FR_AT
    #undef FR_AT
#endif /* ifdef FR_AT */
#define FR_AT RALT(KC_NUHS)
#define MC_MPRV KC_F7
#define MC_MPLY  KC_F8
#define MC_MNXT KC_F9
#define MC_MUTE KC_F10
#define MC_VOLD KC_F11
#define MC_VOLU KC_F12

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

/* BASE
 * ,-----------------------------------------.                    ,-----------------------------------------.
 * | ESC  |   1  |   2  |   3  |   4  |   5  |                    |   6  |   7  |   8  |   9  |   0  |  `   |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * | Tab  |   Q  |   W  |   E  |   R  |   T  |                    |   Y  |   U  |   I  |   O  |   P  |  -   |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * |LCTRL |   A  |   S  |   D  |   F  |   G  |-------.    ,-------|   H  |   J  |   K  |   L  |   ;  |  '   |
 * |------+------+------+------+------+------|   [   |    |    ]  |------+------+------+------+------+------|
 * |LShift|   Z  |   X  |   C  |   V  |   B  |-------|    |-------|   N  |   M  |   ,  |   .  |   /  |RShift|
 * `-----------------------------------------/       /     \      \-----------------------------------------'
 *                   | LAlt | LGUI |LOWER | /Space  /       \Enter \  |RAISE |BackSP| RGUI |
 *                   |      |      |      |/       /         \      \ |      |      |      |
 *                   `----------------------------'           '------''--------------------'
 */

 [_BASE] = LAYOUT(
  FR_AT,   KC_1,   KC_2,    KC_3,    KC_4,    KC_5,                      KC_0,    KC_7,    KC_8,    KC_9,    KC_MINUS,     KC_EQL,
  KC_TAB,   KC_Q,   KC_W,    KC_E,    KC_R,    KC_T,                     KC_Y,    KC_U,    KC_I,    KC_O,    KC_P,    KC_GRV,
  LCTL_T(KC_ESC), KC_A, LSFT_T(KC_S), LGUI_T(KC_D), KC_F, KC_G,                  RALT_T(KC_H),    LSFT_T(KC_J),    KC_K,    KC_L,    KC_SCLN, KC_QUOT,
  KC_LSFT,  KC_Z,   KC_X,    KC_C,    KC_V,    KC_B, KC_LBRC,  KC_RBRC,  KC_N,    KC_M,    KC_COMM, KC_DOT,  KC_MINUS, KC_SLSH,
                        KC_LALT, KC_LGUI, MO(_LOWER), KC_SPC, KC_ENT, MO(_RAISE), KC_BSPC, LT(_FN, XXXXXXX)
),

/** LEFT **/
[_LOWER] = LAYOUT(
  QK_BOOT, EE_CLR, _______, _______, _______, S(RALT(KC_5)),                   _______, _______, _______,_______, S(RALT(KC_MINUS)), KC_DEL,
  FR_COMM, FR_1, FR_2, FR_3, FR_4,  FR_5,                                          FR_6, FR_7, FR_8, FR_9, FR_0, FR_COMM,
  S(KC_PDOT), FR_6, FR_7, FR_8, FR_9, FR_0,                                  XXXXXXX, KC_UNDS, KC_PLUS, KC_LCBR, KC_RCBR, KC_PIPE,
  KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_F6,     KC_PDOT, S(KC_PDOT),  KC_F7,   KC_F8,   KC_F9,   KC_F10,  KC_F11,  KC_F12,
                             _______, _______, _______, _______, _______,  _______, KC_DEL, _______
),

/** RIGHT **/
[_RAISE] = LAYOUT(
  _______, _______, _______, _______, _______, RALT(KC_5),                                              QK_BOOT, EE_CLR, RALT(KC_8), RALT(KC_9), RALT(KC_MINUS), RALT(KC_EQL),
  S(RALT(KC_5)), S(RALT(KC_MINUS)), KC_5, S(RALT(KC_5)), S(RALT(KC_MINUS)), RALT(KC_5),                         KC_DOT, KC_COMM, FR_SLSH, S(RALT(KC_L)), RALT(KC_MINUS), KC_LBRC,
  KC_F1,  KC_F2,    KC_F3,   KC_F4,   KC_F5,   KC_5,                                                   KC_RALT, KC_LEFT, KC_UP, KC_DOWN,   KC_RGHT, FR_GRV,
  KC_LSFT,   KC_F8,   KC_F9,   KC_F10,  KC_F11,  KC_F12,                         KC_PDOT, S(KC_PDOT),   S(KC_PDOT), RALT(FR_N), FR_EQL,  RALT(FR_SLSH), FR_RBRC, RALT(FR_SLSH),
                                                    _______, _______, _______,  _______, _______,  _______, KC_DEL, _______
),
[_FN] = LAYOUT(
  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                   XXXXXXX, XXXXXXX, XXXXXXX, KC_MCTL, XXXXXXX, XXXXXXX,
  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                   MC_MUTE, MC_MPRV, MC_MPLY, MC_MNXT, MC_VOLD, MC_VOLU,
  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                   XXXXXXX, RALT(KC_LEFT), XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
                             _______, _______, _______,  _______, _______,  _______, _______, _______
),


/* ADJUST
 * ,-----------------------------------------.                    ,-----------------------------------------.
 * |      |      |      |      |      |      |                    |      |      |      |      |      |      |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * |      |      |      |      |      |      |                    |      |      |      |      |      |      |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * |      |      |      |      |      |      |-------.    ,-------|      |      |RGB ON| HUE+ | SAT+ | VAL+ |
 * |------+------+------+------+------+------|       |    |       |------+------+------+------+------+------|
 * |      |      |      |      |      |      |-------|    |-------|      |      | MODE | HUE- | SAT- | VAL- |
 * `-----------------------------------------/       /     \      \-----------------------------------------'
 *                   | LAlt | LGUI |LOWER | /Space  /       \Enter \  |RAISE |BackSP| RGUI |
 *                   |      |      |      |/       /         \      \ |      |      |      |
 *                   `----------------------------'           '------''--------------------'
 */
  [_ADJUST] = LAYOUT(
  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                   XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                   XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                   XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
                             _______, _______, _______, _______, _______,  _______, _______, _______
  )
};

layer_state_t layer_state_set_user(layer_state_t state) {
  return update_tri_layer_state(state, _LOWER, _RAISE, _ADJUST);
}

//SSD1306 OLED update loop, make sure to enable OLED_ENABLE=yes in rules.mk
#ifdef OLED_ENABLE

oled_rotation_t oled_init_user(oled_rotation_t rotation) {
  if (!is_keyboard_master())
    return OLED_ROTATION_180;  // flips the display 180 degrees if offhand
  return rotation;
}

// When you add source files to SRC in rules.mk, you can use functions.
const char *read_logo(void);
const char *read_layer_state(void);
void set_keylog(uint16_t keycode, keyrecord_t *record);
const char *read_keylog(void);
const char *read_keylogs(void);

// const char *read_mode_icon(bool swap);
// const char *read_host_led_state(void);
// void set_timelog(void);
// const char *read_timelog(void);

bool oled_task_user(void) {
  if (is_keyboard_master()) {
    // If you want to change the display of OLED, you need to change here
    oled_write_ln(read_layer_state(), false);
    oled_write_ln(read_keylog(), false);
    oled_write_ln(read_keylogs(), false);
    //oled_write_ln(read_mode_icon(keymap_config.swap_lalt_lgui), false);
    //oled_write_ln(read_host_led_state(), false);
    //oled_write_ln(read_timelog(), false);
  } else {
    oled_write(read_logo(), false);
  }
    return false;
}
#endif // OLED_ENABLE

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  if (record->event.pressed) {
#ifdef OLED_ENABLE
    set_keylog(keycode, record);
#endif
    // set_timelog();
  }
  return true;
}
