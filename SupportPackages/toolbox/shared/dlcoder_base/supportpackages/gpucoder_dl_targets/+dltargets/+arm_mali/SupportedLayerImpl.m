




classdef SupportedLayerImpl<handle
    properties(Constant,Access=public)
        m_supportedLayers=dltargets.arm_mali.SupportedLayerImpl.initSupportedLayers();
        m_sourceFiles=dltargets.arm_mali.SupportedLayerImpl.getSourceFiles();
        m_headerFiles=dltargets.arm_mali.SupportedLayerImpl.getHeaderFiles();
        componentRootDir=fullfile(matlabroot,'toolbox','gpucoder_dl_targets_src');
        rootDir=fullfile(dltargets.arm_mali.SupportedLayerImpl.componentRootDir,'arm_mali');
    end

    methods(Static=true)

        function rootDir=getInstallDir
            [flag,rootDir]=dlcoder_base.internal.isGpuCoderDLTargetsInstalled;
            assert(flag);
            assert(~isempty(rootDir));
        end

        function supportedLayers=initSupportedLayers()
            supportedLayers={'gpucoder.input_layer_comp',...
            'gpucoder.conv_layer_comp',...
            'gpucoder.output_layer_comp',...
            'gpucoder.relu_layer_comp',...
            'gpucoder.norm_layer_comp',...
            'gpucoder.max_pool_layer_comp',...
            'gpucoder.softmax_layer_comp',...
            'gpucoder.fc_layer_comp',...
            'gpucoder.pass_through_layer_comp',...
            'gpucoder.addition_layer_comp',...
            'gpucoder.concatenation_layer_comp',...
            'gpucoder.batch_norm_layer_comp',...
            'gpucoder.avg_pool_layer_comp',...
            'gpucoder.fused_conv_activation_layer_comp',...
            'gpucoder.leakyrelu_layer_comp',...
            'gpucoder.clippedrelu_layer_comp',...
            'gpucoder.transposedconv_layer_comp',...
            'MWCrop2dLayer',...
            'MWYoloTransformLayer',...
            'MWScalingLayer',...
            'MWYoloExtractionLayer',...
            'MWSigmoidLayer',...
            'MWYoloSoftmaxLayer',...
            'MWExponentialLayer',...
            'MWYoloReorg2dLayer',...
            'MWFlattenCStyleLayer',...
            'MWTanhLayer',...
            'MWZeroPaddingLayer',...
            'MWRowMajorFlattenLayer',...
            'MWSplittingLayer',...
'gpucoder.elementwise_affine_layer_comp'
            };
        end


        function sourceFiles=getSourceFiles()
            keys=dltargets.arm_mali.SupportedLayerImpl.m_supportedLayers;
            values=cell(numel(keys),1);
            sourceFiles=containers.Map(keys,values);
            sourceFiles('gpucoder.input_layer_comp')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliInputLayerImpl.cpp');
            sourceFiles('gpucoder.relu_layer_comp')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliReLULayerImpl.cpp');
            sourceFiles('gpucoder.norm_layer_comp')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliNormLayerImpl.cpp');
            sourceFiles('gpucoder.avg_pool_layer_comp')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliAvgPoolingLayerImpl.cpp');
            sourceFiles('gpucoder.fc_layer_comp')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliFCLayerImpl.cpp');
            sourceFiles('gpucoder.max_pool_layer_comp')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliMaxPoolingLayerImpl.cpp');
            sourceFiles('gpucoder.softmax_layer_comp')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliSoftmaxLayerImpl.cpp');
            sourceFiles('gpucoder.output_layer_comp')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliOutputLayerImpl.cpp');
            sourceFiles('gpucoder.addition_layer_comp')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliAdditionLayerImpl.cpp');
            sourceFiles('gpucoder.concatenation_layer_comp')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliConcatenationLayerImpl.cpp');
            sourceFiles('gpucoder.batch_norm_layer_comp')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliBatchNormalizationLayerImpl.cpp');
            sourceFiles('gpucoder.conv_layer_comp')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliConvLayerImpl.cpp');
            sourceFiles('gpucoder.fused_conv_activation_layer_comp')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliFusedConvActivationLayerImpl.cpp');
            sourceFiles('gpucoder.leakyrelu_layer_comp')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliLeakyReLULayerImpl.cpp');
            sourceFiles('gpucoder.clippedrelu_layer_comp')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliClippedReLULayerImpl.cpp');
            sourceFiles('gpucoder.transposedconv_layer_comp')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliTransposedConvolution2DLayerImpl.cpp');
            sourceFiles('MWScalingLayer')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliScalingLayerImpl.cpp');
            sourceFiles('MWYoloExtractionLayer')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliYoloExtractionLayerImpl.cpp');
            sourceFiles('MWSigmoidLayer')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliSigmoidLayerImpl.cpp');
            sourceFiles('MWYoloSoftmaxLayer')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliYoloSoftmaxLayerImpl.cpp');
            sourceFiles('MWExponentialLayer')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliExponentialLayerImpl.cpp');
            sourceFiles('MWYoloReorg2dLayer')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliYoloReorg2dLayerImpl.cpp');
            sourceFiles('MWFlattenCStyleLayer')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliFlattenCStyleLayerImpl.cpp');
            sourceFiles('MWTanhLayer')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliTanhLayerImpl.cpp');
            sourceFiles('MWZeroPaddingLayer')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliZeroPaddingLayerImpl.cpp');
            sourceFiles('MWRowMajorFlattenLayer')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliRowMajorFlattenLayerImpl.cpp');
            sourceFiles('MWSplittingLayer')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliSplittingLayerImpl.cpp');
            sourceFiles('gpucoder.elementwise_affine_layer_comp')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliElementwiseAffineLayerImpl.cpp');
            sourceFiles('MWCrop2dLayer')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliCrop2dLayerImpl.cpp');

        end

        function headerFiles=getHeaderFiles()
            keys=dltargets.arm_mali.SupportedLayerImpl.m_supportedLayers;
            values=cell(numel(keys),1);
            headerFiles=containers.Map(keys,values);
            headerFiles('gpucoder.input_layer_comp')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliInputLayerImpl.hpp');
            headerFiles('gpucoder.relu_layer_comp')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliReLULayerImpl.hpp');
            headerFiles('gpucoder.norm_layer_comp')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliNormLayerImpl.hpp');
            headerFiles('gpucoder.avg_pool_layer_comp')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliAvgPoolingLayerImpl.hpp');
            headerFiles('gpucoder.fc_layer_comp')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliFCLayerImpl.hpp');
            headerFiles('gpucoder.max_pool_layer_comp')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliMaxPoolingLayerImpl.hpp');
            headerFiles('gpucoder.softmax_layer_comp')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliSoftmaxLayerImpl.hpp');
            headerFiles('gpucoder.output_layer_comp')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliOutputLayerImpl.hpp');
            headerFiles('gpucoder.conv_layer_comp')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliConvLayerImpl.hpp');
            headerFiles('gpucoder.addition_layer_comp')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliAdditionLayerImpl.hpp');
            headerFiles('gpucoder.concatenation_layer_comp')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliConcatenationLayerImpl.hpp');
            headerFiles('gpucoder.batch_norm_layer_comp')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliBatchNormalizationLayerImpl.hpp');
            headerFiles('gpucoder.fused_conv_activation_layer_comp')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliFusedConvActivationLayerImpl.hpp');
            headerFiles('gpucoder.leakyrelu_layer_comp')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliLeakyReLULayerImpl.hpp');
            headerFiles('gpucoder.clippedrelu_layer_comp')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliClippedReLULayerImpl.hpp');
            headerFiles('gpucoder.transposedconv_layer_comp')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliTransposedConvolution2DLayerImpl.hpp');
            headerFiles('MWScalingLayer')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliScalingLayerImpl.hpp');
            headerFiles('MWYoloExtractionLayer')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliYoloExtractionLayerImpl.hpp');
            headerFiles('MWSigmoidLayer')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliSigmoidLayerImpl.hpp');
            headerFiles('MWYoloSoftmaxLayer')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliYoloSoftmaxLayerImpl.hpp');
            headerFiles('MWExponentialLayer')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliExponentialLayerImpl.hpp');
            headerFiles('MWYoloReorg2dLayer')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliYoloReorg2dLayerImpl.hpp');
            headerFiles('MWFlattenCStyleLayer')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliFlattenCStyleLayerImpl.hpp');
            headerFiles('MWTanhLayer')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliTanhLayerImpl.hpp');
            headerFiles('MWZeroPaddingLayer')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliZeroPaddingLayerImpl.hpp');
            headerFiles('MWRowMajorFlattenLayer')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliRowMajorFlattenLayerImpl.hpp');
            headerFiles('MWSplittingLayer')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliSplittingLayerImpl.hpp');
            headerFiles('gpucoder.elementwise_affine_layer_comp')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliElementwiseAffineLayerImpl.hpp');
            headerFiles('MWCrop2dLayer')=...
            fullfile(dltargets.arm_mali.SupportedLayerImpl.rootDir,'MWArmmaliCrop2dLayerImpl.hpp');


        end
    end
end

