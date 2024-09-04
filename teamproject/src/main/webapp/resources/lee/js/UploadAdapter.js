class UploadAdapter {
	constructor(loader, url) {
		this.loader = loader;
		this.url = url;
	}
   upload() {
        var reader  = new FileReader();
    
        return new Promise( ( resolve, reject ) => {
            reader.addEventListener( 'load', () => {
                resolve( { default: reader.result } );
            });
    
            reader.addEventListener( 'error', err => {
                reject( err );
            });
    
            reader.addEventListener( 'abort', () => {
                reject();
            });                    
    
            this.loader.file.then( file => {
                reader.readAsDataURL( file );
            });                        
        })
    }
	abort() {
		if ( this.xhr ) {
			this.xhr.abort();
		}
	}
	_initRequest() {
		const xhr = this.xhr = new XMLHttpRequest();
		xhr.open('POST', this.url, true);
		xhr.responseType = 'json';
	}
	_initListeners(resolve, reject, file) {
		const xhr = this.xhr;
		const loader = this.loader;
		const genericErrorText = '파일을 업로드 할 수 없습니다. : '+file.name;

		xhr.addEventListener('error', () => {reject(genericErrorText)})
		xhr.addEventListener('abort', () => reject())
		xhr.addEventListener('load', () => {
			const response = xhr.response
			if (!response || response.error) {
				return reject( response && response.error ? response.error.message : genericErrorText );
			}
			resolve({
				default: response.url
			})
		})
	}
	_sendRequest(file) {
		const data = new FormData()
		data.append('upload',file)
		this.xhr.send(data)
	}
}