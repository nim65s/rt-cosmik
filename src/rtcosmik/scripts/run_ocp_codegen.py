from rtcosmik.config_loader import settings
from rtcosmik.ik.ik import RT_SWIKA_FATROP
from rtcosmik.human_model.pin_model import build_dummy_model_no_visuals


def main():
    human_model = build_dummy_model_no_visuals()

    ik_class = RT_SWIKA_FATROP(human_model, settings.keys_to_track_list, settings.N)
    ik_class.compile_Ccode()


if __name__ == "__main__":
    main()
