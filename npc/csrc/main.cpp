#include <nvboard.h>
#include "Vdual_switch.h"

static TOP_NAME dut;

void nvboard_bind_all_pins(Vdual_switch *top);

int main()
{
  nvboard_bind_all_pins(&dut);
  nvboard_init();

  while (1)
  {
    dut.eval();
    nvboard_update();
  }
}
