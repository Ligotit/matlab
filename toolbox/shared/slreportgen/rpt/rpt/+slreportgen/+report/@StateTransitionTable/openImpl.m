function result=openImpl(reporter,impl,varargin)
    if isempty(varargin)
        key=['E2CxocC0AQVPieCaF6zwSyc9nOou+oJemGrqO31KsIJ0wTl5Hra4a7JQNxE4'...
        ,'zuKtQhzfC0R1ghYh0T83QeWqDlEc7ZJaIT9ruA7zP9dOHTbsVEusRj3tCb4W'...
        ,'6zc9rViVedEa7ylyyJkEfeyw9Bqj5RqhAGVJQI5AH8pZpAzvrMYiq4226JUj'...
        ,'C56n4YaOOZxcdXFoiKmlZQVbwru9ctoVNAOQdF1ulAfnwZ9kX8v4AKzvJyTz'...
        ,'2g7ZiXp9M8Tla5n9pEmWbtRbwhqsLtKsUqSgUU+vhUxxHlsFFzQ7wwJ1Ergh'...
        ,'VaF76mHqdYAo'];
    else
        key=varargin{1};
    end
    result=open(impl,key,reporter);
end