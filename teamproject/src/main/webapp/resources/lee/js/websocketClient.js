export function initializeWebSocket(onMessageCallback, onOpenCallback, onCloseCallback) {
    const socket = new WebSocket("ws://localhost/ws");

    socket.onmessage = function(event) {
        if (onMessageCallback) {
            onMessageCallback(event.data);
            console.log("onmessage: ", event.data);
        }
    };

    socket.onopen = function() {
        if (onOpenCallback) {
            onOpenCallback();
        }
        console.log("onOpenCallback()");
    };

    socket.onclose = function() {
        if (onCloseCallback) {
            onCloseCallback();
        }
        console.log("onCloseCallback()");
    };

    return socket;
}