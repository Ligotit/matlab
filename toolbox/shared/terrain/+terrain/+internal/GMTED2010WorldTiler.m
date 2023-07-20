classdef(Sealed,Hidden)GMTED2010WorldTiler<terrain.internal.Tiler




    properties(Constant)
        VoidValue=-32768
        TerrainName='gmted2010world'
        DefaultMaxZoomLevel=10
        PartialGreenlandLowResolutionFiles=[...
        "70N090W_20101117_gmted_mea300.tif",...
        "70N060W_20101117_gmted_mea300.tif",...
        "70N030W_20101117_gmted_mea300.tif",...
        "50N060W_20101117_gmted_mea300.tif",...
        "50N030W_20101117_gmted_mea300.tif"]
        PartialAntarcticaLowResolutionFiles=[...
        "70S000E_20101117_gmted_mea300.tif",...
        "70S030E_20101117_gmted_mea300.tif",...
        "70S030W_20101117_gmted_mea300.tif",...
        "70S060E_20101117_gmted_mea300.tif",...
        "70S060W_20101117_gmted_mea300.tif",...
        "70S090E_20101117_gmted_mea300.tif",...
        "70S090W_20101117_gmted_mea300.tif",...
        "70S120E_20101117_gmted_mea300.tif",...
        "70S120W_20101117_gmted_mea300.tif",...
        "70S150E_20101117_gmted_mea300.tif",...
        "70S150W_20101117_gmted_mea300.tif",...
        "70S180W_20101117_gmted_mea300.tif"]
        FullAntarcticaLowResolutionFiles=[...
        "90S000E_20101117_gmted_mea300.tif",...
        "90S030E_20101117_gmted_mea300.tif",...
        "90S030W_20101117_gmted_mea300.tif",...
        "90S060E_20101117_gmted_mea300.tif",...
        "90S060W_20101117_gmted_mea300.tif",...
        "90S090E_20101117_gmted_mea300.tif",...
        "90S090W_20101117_gmted_mea300.tif",...
        "90S120E_20101117_gmted_mea300.tif",...
        "90S120W_20101117_gmted_mea300.tif",...
        "90S150E_20101117_gmted_mea300.tif",...
        "90S150W_20101117_gmted_mea300.tif",...
        "90S180W_20101117_gmted_mea300.tif"]
        HighResolutionFiles=[...
        "10N000E_20101117_gmted_mea075.tif",...
        "10N030E_20101117_gmted_mea075.tif",...
        "10N030W_20101117_gmted_mea075.tif",...
        "10N060E_20101117_gmted_mea075.tif",...
        "10N060W_20101117_gmted_mea075.tif",...
        "10N090E_20101117_gmted_mea075.tif",...
        "10N090W_20101117_gmted_mea075.tif",...
        "10N120E_20101117_gmted_mea075.tif",...
        "10N120W_20101117_gmted_mea075.tif",...
        "10N150E_20101117_gmted_mea075.tif",...
        "10N150W_20101117_gmted_mea075.tif",...
        "10N180W_20101117_gmted_mea075.tif",...
        "10S000E_20101117_gmted_mea075.tif",...
        "10S030E_20101117_gmted_mea075.tif",...
        "10S030W_20101117_gmted_mea075.tif",...
        "10S060E_20101117_gmted_mea075.tif",...
        "10S060W_20101117_gmted_mea075.tif",...
        "10S090E_20101117_gmted_mea075.tif",...
        "10S090W_20101117_gmted_mea075.tif",...
        "10S120E_20101117_gmted_mea075.tif",...
        "10S120W_20101117_gmted_mea075.tif",...
        "10S150E_20101117_gmted_mea075.tif",...
        "10S150W_20101117_gmted_mea075.tif",...
        "10S180W_20101117_gmted_mea075.tif",...
        "30N000E_20101117_gmted_mea075.tif",...
        "30N030E_20101117_gmted_mea075.tif",...
        "30N030W_20101117_gmted_mea075.tif",...
        "30N060E_20101117_gmted_mea075.tif",...
        "30N060W_20101117_gmted_mea075.tif",...
        "30N090E_20101117_gmted_mea075.tif",...
        "30N090W_20101117_gmted_mea075.tif",...
        "30N120E_20101117_gmted_mea075.tif",...
        "30N120W_20101117_gmted_mea075.tif",...
        "30N150E_20101117_gmted_mea075.tif",...
        "30N150W_20101117_gmted_mea075.tif",...
        "30N180W_20101117_gmted_mea075.tif",...
        "30S000E_20101117_gmted_mea075.tif",...
        "30S030E_20101117_gmted_mea075.tif",...
        "30S030W_20101117_gmted_mea075.tif",...
        "30S060E_20101117_gmted_mea075.tif",...
        "30S060W_20101117_gmted_mea075.tif",...
        "30S090E_20101117_gmted_mea075.tif",...
        "30S090W_20101117_gmted_mea075.tif",...
        "30S120E_20101117_gmted_mea075.tif",...
        "30S120W_20101117_gmted_mea075.tif",...
        "30S150E_20101117_gmted_mea075.tif",...
        "30S150W_20101117_gmted_mea075.tif",...
        "30S180W_20101117_gmted_mea075.tif",...
        "50N000E_20101117_gmted_mea075.tif",...
        "50N030E_20101117_gmted_mea075.tif",...
        "50N060E_20101117_gmted_mea075.tif",...
        "50N090E_20101117_gmted_mea075.tif",...
        "50N090W_20101117_gmted_mea075.tif",...
        "50N120E_20101117_gmted_mea075.tif",...
        "50N120W_20101117_gmted_mea075.tif",...
        "50N150E_20101117_gmted_mea075.tif",...
        "50N150W_20101117_gmted_mea075.tif",...
        "50N180W_20101117_gmted_mea075.tif",...
        "50S000E_20101117_gmted_mea075.tif",...
        "50S030E_20101117_gmted_mea075.tif",...
        "50S030W_20101117_gmted_mea075.tif",...
        "50S060E_20101117_gmted_mea075.tif",...
        "50S060W_20101117_gmted_mea075.tif",...
        "50S090E_20101117_gmted_mea075.tif",...
        "50S090W_20101117_gmted_mea075.tif",...
        "50S120E_20101117_gmted_mea075.tif",...
        "50S120W_20101117_gmted_mea075.tif",...
        "50S150E_20101117_gmted_mea075.tif",...
        "50S150W_20101117_gmted_mea075.tif",...
        "50S180W_20101117_gmted_mea075.tif",...
        "70N000E_20101117_gmted_mea075.tif",...
        "70N030E_20101117_gmted_mea075.tif",...
        "70N060E_20101117_gmted_mea075.tif",...
        "70N090E_20101117_gmted_mea075.tif",...
        "70N120E_20101117_gmted_mea075.tif",...
        "70N120W_20101117_gmted_mea075.tif",...
        "70N150E_20101117_gmted_mea075.tif",...
        "70N150W_20101117_gmted_mea075.tif",...
        "70N180W_20101117_gmted_mea075.tif"];
    end

    properties(SetAccess=immutable)
SourceFileFolder
    end

    methods
        function tiler=GMTED2010WorldTiler(sourceFolder,writeLocation,maxZoomLevel,name)


            sourceFiles=fullfile(sourceFolder,terrain.internal.GMTED2010WorldTiler.HighResolutionFiles);





            lowresfiles=fullfile(sourceFolder,[...
            terrain.internal.GMTED2010WorldTiler.PartialGreenlandLowResolutionFiles,...
            terrain.internal.GMTED2010WorldTiler.PartialAntarcticaLowResolutionFiles]);
            for lowresFile=lowresfiles
                highresFile=replace(lowresFile,"300.tif","075.tif");
                mergedFile=replace(lowresFile,"300.tif","_merged.tif");
                if~exist(mergedFile,'file')
                    writeMergedFile(mergedFile,lowresFile,highresFile)
                end
                sourceFiles(end+1)=mergedFile;%#ok<AGROW>
            end



            antFiles=fullfile(sourceFolder,terrain.internal.GMTED2010WorldTiler.FullAntarcticaLowResolutionFiles);
            for antFile=antFiles
                newFile=replace(antFile,"300.tif","300_ref.tif");
                if~exist(newFile,'file')
                    writeAntarcticaFile(newFile,antFile)
                end
                sourceFiles(end+1)=newFile;%#ok<AGROW>
            end


            if nargin<3
                maxZoomLevel=terrain.internal.GMTED2010WorldTiler.DefaultMaxZoomLevel;
            end
            if nargin<4
                name=terrain.internal.GMTED2010WorldTiler.TerrainName;
            end
            terrainSource=terrain.internal.TerrainSource.createFromFiles(name,sourceFiles,...
            'FillMissing',false,...
            'MissingDataReplaceValue',0,...
            'HeightReference','geoid');
            tiler@terrain.internal.Tiler(terrainSource,writeLocation,...
            'MaxZoomLevel',maxZoomLevel);
            tiler.SourceFileFolder=sourceFolder;
        end

        function gzipFolders(tiler,folders)


            for folderInd=1:numel(folders)
                gzipFolders@terrain.internal.Tiler(tiler,folders(folderInd));
            end
        end

        function addTerrain(tiler)


            s=settings;
            terrainSettings=s.shared.terrain;
            terrainSource=tiler.TerrainSource;
            g=terrainSettings.addGroup(terrainSource.Name);
            g.addSetting('Location','PersonalValue',char(tiler.WriteLocation));
            g.addSetting('IsURLLocation','PersonalValue',false);
            g.addSetting('MaxZoomLevel','PersonalValue',tiler.MaxZoomLevel);
            g.addSetting('Attribution','PersonalValue','World terrain from GMTED2010');
            g.addSetting('IntrinsicResolution','PersonalValue',terrainSource.IntrinsicResolution);
            g.addSetting('LatitudeLimits','PersonalValue',terrainSource.LatitudeLimits);
            g.addSetting('LongitudeLimits','PersonalValue',terrainSource.LongitudeLimits);
            g.addSetting('HeightReference','PersonalValue',tiler.OutputHeightReference);
        end
    end

    methods(Static)
        function surfworld(zoomLevel,numLats,numLons,terrainName)



            if nargin<2
                numLats=512;
                numLons=1024;
            end
            latsv=linspace(-90,90,numLats);
            lonsv=linspace(-180,180,numLons);
            [lons,lats]=meshgrid(lonsv,latsv);


            if nargin<4
                terrainName=terrain.internal.GMTED2010WorldTiler.TerrainName;
            end


            terrainSource=terrain.internal.TerrainSource.createFromSettings(terrainName);
            Z=terrainSource.query(lats,lons,'ZoomLevel',zoomLevel);


            surf(lonsv,latsv,reshape(Z,[numLats,numLons]));
            title("Zoom level "+zoomLevel+" for "+terrainName);
            shading interp;
            view([0,90]);
            xlabel('Longitude');
            ylabel('Latitude');
        end
    end
end

function writeMergedFile(mergedFile,lowresFile,highresFile)


    lowresReader=terrain.internal.GeorasterTileReader(lowresFile);
    highresReader=terrain.internal.GeorasterTileReader(highresFile);
    tileLat=lowresReader.LatitudeLimits(1)+1;
    tileLon=lowresReader.LongitudeLimits(1)+1;
    tileCoordinates=findTiles(lowresReader,tileLat,tileLon);
    [lowresData,lowresLatvs,lowresLonvs]=readTiles(lowresReader,tileCoordinates);
    [highresData,highresLatvs,highresLonvs]=readTiles(highresReader,tileCoordinates);


    terrainData=highresData{1};
    terrainData=replaceVoidValue(terrainData);
    lowresData=lowresData{1};
    lowresData=replaceVoidValue(lowresData);



    F=griddedInterpolant({lowresLatvs{1},lowresLonvs{1}},lowresData);
    lowresTerrainData=F({highresLatvs{1},highresLonvs{1}});



    mask=(terrainData(:)==0)&(lowresTerrainData(:)~=0);
    terrainData(mask)=lowresTerrainData(mask);


    info=geotiffinfo(highresFile);
    terrainData=flipud(terrainData);
    geotiffwrite(mergedFile,terrainData,info.SpatialRef);
end

function writeAntarcticaFile(newFile,antFile)


    Z=geotiffread(antFile);


    lonStr=char(extractBetween(antFile,"90S","_"));
    latMin=-90;
    lonMin=str2double(lonStr(1:3));
    if lonStr(end)=='W'
        lonMin=-lonMin;
    end


    latExtent=20;
    lonExtent=30;
    lonLimits=[lonMin,lonMin+lonExtent];
    latLimits=[latMin,latMin+latExtent];
    R=georefcells(latLimits,lonLimits,size(Z),'ColumnsStartFrom','north');


    geotiffwrite(newFile,Z,R);
end

function data=replaceVoidValue(data)

    mask=(data==terrain.internal.GMTED2010WorldTiler.VoidValue);
    data(mask)=0;
end