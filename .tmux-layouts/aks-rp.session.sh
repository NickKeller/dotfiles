session_root "/home/azureuser/go/src/aks-rp"

if initialize_session "aks-rp"; then
    new_window "editor"
    run_cmd "vi"
    new_window "terminal"
    select_window 1
fi

finalize_and_go_to_session

