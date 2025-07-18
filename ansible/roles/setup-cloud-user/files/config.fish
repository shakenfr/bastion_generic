#!/usr/bin/env fish
# Main file for fish command completions. This file contains various
# common helper functions for the command completions. All actual
# completions are located in the completions subdirectory.
#
# Set default field separators
#
set -g IFS \n\ \t
set -qg __fish_added_user_paths
or set -g __fish_added_user_paths
#alias helm3="/helm3/helm"
#alias mongo4="/mongo4/bin/mongo"
alias occ="oc --kubeconfig /openshift/config.yaml config use-context btd-sandbox"
alias k="kubectl"
alias kv="kubectl config view"
alias kk="kustomize build .|kubectl apply -f -"
alias

# For one-off upgrades of the fish version, see __fish_config_interactive.fish
if not set -q __fish_initialized
    set -U __fish_initialized 0
    if set -q __fish_init_2_39_8
        set __fish_initialized 2398
    else if set -q __fish_init_2_3_0
        set __fish_initialized 2300
    end
end

#
# Create the default command_not_found handler
#
function __fish_default_command_not_found_handler
    printf "fish: Unknown command: %s\n" (string escape -- $argv[1]) >&2
end

if not status --is-interactive
    # Hook up the default as the command_not_found handler
    # if we are not interactive to avoid custom handlers.
    function fish_command_not_found --on-event fish_command_not_found
        __fish_default_command_not_found_handler $argv
    end
end

#
# Set default search paths for completions and shellscript functions
# unless they already exist
#

# __fish_data_dir, __fish_sysconf_dir, __fish_help_dir, __fish_bin_dir
# are expected to have been set up by read_init from fish.cpp

# Grab extra directories (as specified by the build process, usually for
# third-party packages to ship completions &c.
set -l __extra_completionsdir
set -l __extra_functionsdir
set -l __extra_confdir
if test -f $__fish_data_dir/__fish_build_paths.fish
    source $__fish_data_dir/__fish_build_paths.fish
end

# Compute the directories for vendor configuration.  We want to include
# all of XDG_DATA_DIRS, as well as the __extra_* dirs defined above.
set -l xdg_data_dirs
if set -q XDG_DATA_DIRS
    set --path xdg_data_dirs $XDG_DATA_DIRS
    set xdg_data_dirs (string replace -r '([^/])/$' '$1' -- $xdg_data_dirs)/fish
else
    set xdg_data_dirs $__fish_data_dir
end

set -l vendor_completionsdirs
set -l vendor_functionsdirs
set -l vendor_confdirs
# Don't load vendor directories when running unit tests
if not set -q FISH_UNIT_TESTS_RUNNING
    set vendor_completionsdirs $xdg_data_dirs/vendor_completions.d
    set vendor_functionsdirs $xdg_data_dirs/vendor_functions.d
    set vendor_confdirs $xdg_data_dirs/vendor_conf.d

    # Ensure that extra directories are always included.
    if not contains -- $__extra_completionsdir $vendor_completionsdirs
        set -a vendor_completionsdirs $__extra_completionsdir
    end
    if not contains -- $__extra_functionsdir $vendor_functionsdirs
        set -a vendor_functionsdirs $__extra_functionsdir
    end
    if not contains -- $__extra_confdir $vendor_confdirs
        set -a vendor_confdirs $__extra_confdir
    end
end

# Set up function and completion paths. Make sure that the fish
# default functions/completions are included in the respective path.

if not set -q fish_function_path
    set fish_function_path $__fish_config_dir/functions $__fish_sysconf_dir/functions $vendor_functionsdirs $__fish_data_dir/functions
else if not contains -- $__fish_data_dir/functions $fish_function_path
    set -a fish_function_path $__fish_data_dir/functions
end

