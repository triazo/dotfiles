#include <stdio.h>

#include <stdlib.h>

#include <unistd.h>

#include <linux/input.h>

/* Compile with clang or gcc, and put the binary at /usr/bin/rwin2ctrl */
/* set up by installing interception, and create a file /etc/interception/udevmon.d/rwin2ctrl.yaml


- JOB: "intercept -g $DEVNODE | /usr/bin/rwin2ctrl | uinput -d $DEVNODE"
  DEVICE:
    NAME: "Apple MTP keyboard"


After installation, restart udevmon

*/


int read_event(struct input_event *event) {

  return fread(event, sizeof(struct input_event), 1, stdin) == 1;

}

void write_event(const struct input_event *event) {

  if (fwrite(event, sizeof(struct input_event), 1, stdout) != 1) {

    exit(EXIT_FAILURE);

  }

}

int main() {

  struct input_event input;

  setbuf(stdin, NULL), setbuf(stdout, NULL);

  while (read_event(&input)) {

    if (input.type == EV_MSC && input.code == MSC_SCAN) {

      continue;

    }

    if (input.type == EV_KEY && input.code == KEY_RIGHTALT) {

      struct input_event rctrl = {.type = EV_KEY, .code = KEY_RIGHTCTRL, .value = input.value};

      write_event(&rctrl);

      continue;

    }

    if (input.type == EV_KEY && input.code == KEY_RIGHTMETA) {

      struct input_event ralt = {.type = EV_KEY, .code = KEY_RIGHTALT, .value = input.value};

      write_event(&ralt);

      continue;
    }
    if (input.type == EV_KEY && input.code == KEY_LEFTCTRL) {

      struct input_event lmeta = {.type = EV_KEY, .code = KEY_LEFTALT, .value = input.value};

      write_event(&lmeta);

      continue;
    }

    if (input.type == EV_KEY && input.code == KEY_LEFTALT) {

      struct input_event lctrl = {.type = EV_KEY, .code = KEY_LEFTCTRL, .value = input.value};

      write_event(&lctrl);

      continue;
    }

    write_event(&input);

  }
}
