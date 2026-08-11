from argparse import ArgumentParser
from multiprocessing import set_start_method
from pathlib import Path
from sys import argv

import argcomplete

from rtcosmik.scripts import run_nlf_inference, run_triangulation, run_pipeline


def add_arguments(p: ArgumentParser):
    subparsers = p.add_subparsers(help="subcommands")

    nlf_p = subparsers.add_parser("nlf-inference")
    nlf_p.set_defaults(cmd="nlf")
    run_nlf_inference.add_arguments(nlf_p)

    tri_p = subparsers.add_parser("triangulation")
    tri_p.set_defaults(cmd="tri")
    run_triangulation.add_arguments(tri_p)

    pip_p = subparsers.add_parser("pipeline")
    pip_p.set_defaults(cmd="pip")
    run_pipeline.add_arguments(pip_p)


def main():
    p = ArgumentParser()
    argcomplete.autocomplete(p)
    add_arguments(p)
    args = p.parse_args()

    if "cmd" not in args:
        p.print_help()
        return

    if args.online:
        set_start_method("spawn")

    if args.cmd == "nlf":
        run_nlf_inference.run_nlf_inference(args)
    elif args.cmd == "tri":
        run_triangulation.run_triangulation(args)
    elif args.cmd == "pip":
        run_pipeline.run_pipeline(args)


if __name__ == "__main__":
    main()
