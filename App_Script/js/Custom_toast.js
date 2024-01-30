//MsgType: 1(Success),2(Warning),3(Error),4(Information),default
//Position: bottom-left,bottom-right,bottom-center,top-right,top-left,top-center,mid-center
function ToastMsg(MsgType, Msg, Position) {
    switch (MsgType) {
        case '1':
            $.toast({
                heading: 'Success',
                text: Msg,
                icon: 'success',
                position: Position,
                showHideTransition: 'plain',
                stack: 1,
            });
            break;
        case '2':
            $.toast({
                heading: 'Warning',
                text: Msg,
                icon: 'warning',
                position: Position,
                showHideTransition: 'plain',
                stack: 1,
            });
            break;
        case '3':
            $.toast({
                heading: 'Error',
                text: Msg,
                icon: 'error',
                position: Position,
                showHideTransition: 'plain',
                stack: 1,
            });
            break;
        case '4':
            $.toast({
                heading: 'Information',
                text: Msg,
                icon: 'info',
                position: Position,
                showHideTransition: 'plain',
                stack: 1,
            });
            break;
        default:
            $.toast({
                text: Msg,
                position: Position,
                showHideTransition: 'plain',
                stack: 1,
            });
            break;
    }
}