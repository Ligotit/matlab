function varargout=brick_solid(varargin)



    persistent BlockInfoCache
    mlock;

    if isempty(BlockInfoCache)
        blockReader=simmechanics.library.helper.BlockXmlReader('brickSolid');
        BlockInfoCache=blockReader.generateBlockInfo(mfilename('fullpath'),...
        pm_message('sm:library:bodyElements:brickSolid:Name'));
    end
    BlockInfoCache.HasDialogGraphics=true;

    if nargin==1
        varargout={simmechanics.library.helper.generate_outputs(BlockInfoCache,varargin{1})};
    else
        varargout{1}=BlockInfoCache.copy;
    end

end
