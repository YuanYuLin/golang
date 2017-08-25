import ops
import ops_git
import iopc

TARBALL_FILE="go1.8.3.linux-amd64.tar.gz"
TARBALL_DIR="go"
pkg_path = ""
output_dir = ""
tarball_pkg = ""
tarball_dir = ""
install_dir = ""
GOPATH=""
GOROOT=""
GOARCH=""
GOARM=""
GOOS="linux"

def set_global(args):
    global pkg_path
    global output_dir
    global tarball_pkg
    global install_dir
    global tarball_dir
    global GOROOT
    global GOPATH
    global GOARCH
    global GOARM
    global GOOS
    arch = ops.getEnv("ARCH_ALT")
    pkg_path = args["pkg_path"]
    output_dir = args["output_path"]
    pkg_args = args["pkg_args"]
    web_version = pkg_args["version"]
    tarball_pkg = ops.path_join(pkg_path, TARBALL_FILE)
    tarball_dir = ops.path_join(output_dir, TARBALL_DIR)
    GOROOT=ops.path_join(output_dir, TARBALL_DIR)
    GOPATH=ops.path_join(output_dir, "workspace")

    if arch == "armhf":
        GOARCH=arm
        GOARM=5
    elif arch == "armel":
        GOARCH=arm
        GOARM=5
    elif arch == "x86_64":
        GOARCH=
        GOARM=
    else:
        sys.exit(1)

def MAIN_ENV(args):
    set_global(args)

    ops.mkdir(GOPATH)
    ops.exportEnv(ops.addEnv("GOPATH", GOPATH))
    ops.exportEnv(ops.addEnv("GOROOT", GOROOT))
    ops.exportEnv(ops.addEnv("PATH", ops.path_join(GOROOT, "bin")))
    ops.exportEnv(ops.setEnv("GOARCH", GOARCH))
    ops.exportEnv(ops.setEnv("GOARM", GOARM))
    ops.exportEnv(ops.setEnv("GOOS", GOOS))

    return False

def MAIN_EXTRACT(args):
    set_global(args)

    ops.unTarGz(tarball_pkg, output_dir)

    return True

def MAIN_PATCH(args, patch_group_name):
    set_global(args)
    for patch in iopc.get_patch_list(pkg_path, patch_group_name):
        if iopc.apply_patch(tarball_dir, patch):
            continue
        else:
            sys.exit(1)

    return True

def MAIN_CONFIGURE(args):
    set_global(args)

    return True

def MAIN_BUILD(args):
    set_global(args)

    return False

def MAIN_INSTALL(args):
    set_global(args)

    return False

def MAIN_CLEAN_BUILD(args):
    set_global(args)

    return False

def MAIN(args):
    set_global(args)

