function tree=getTreeForFile(filePathName,fcnType,errorMechanism)





    if isdeployed



        mFileContent=mcl_gpu_util('30820943020100300d06092a864886f70d01010105000482092d308209290201000282020100c6f6440d18771fa96a92d2e639ce8b302a70c2dbcc01d13884bd079135577e1f3f8fff7fa5d5db2eae44968084a01c3d2a32952990126f2471996604ed49bb197beb9347da2a363de55fbe459d73b8320df6eaa6bbb2e838f347187ccbe0800dc42861464ea4856d17ca1c3ff75fd91d55769b6d2e4ba04d138db0499e8be9e8b1d4bc8fe9222a3843813b48d60e473ae21ebff9d09d075e087a27801597cce9fb2c2615fbcc3e4e2629616954de313a8d0060103c92551d970a639b67911602ab1d726fd3f921324a2f026d0798bc970f6f14a03031a8d2cda574c20396c462e82eb67b7413ac588c3d9e625d6bafc662e5fe41b555fcf55d9f245f3aa27a9ecc1c4fc5720b96e09a6acab6f378f4b78272fdd279a091345d4ae9f4c1913042338524b433f7ffe9636011ea1dd82e6992db6a3501a45462982cba0e5e4d82348ddc4f05d88ba6c88f094d1ab6a1de52e618d21e88468dc079bde95fa2120bc5e8d1f53382b02b63829f597d494ffd78d9c847120f288f9f80f61f05cff1c6404c1e5ab610bd655f150d8ffff43bb28b8035ada2a11c4718b854daecf64cbb5712a7a7f61335751d98d96c4b1a96e376191abc79e536e88e3bd18124e4aee35db9e8798ed3bc8eb3153d5ee64a88ce59882b7df3a31d0495a39b3fad1df1bf68567d4718cf834337248336be889d1d7132f041d56cd4630378eaf554b140513f0203010001028202002293575e233b48604ba9fa46921327b3161d046fe7f304e5da83731633fbe16a12c4b674fb5fbfb84c069554fe3748d1044d4808b205d214b63d1f3289fdff2abd9341c401d0c61e59871aecc421010889ceb8168395e2af4aefb6fcb0fd71a372cc45a34f355e0e884cd23df7824b9bc2675b394d0b4d6f378faeec0c466a3ecaf09a5833fe80f1c82164291331e6050098b169fb6bde84e3da3e950eab93abb1bf895ad6a836c7a3f01b02900210f208e0e0d0d185e88ebcd9cc578c56f5493f6d5d9ebb6a96ef435f09ffe28b1372f8f6a7d1f2ae1e958bb14e2a0d2f9d2f47041f283312dc27832f8e1faff66fd47d0954f71c49362d79b8973c89570511d6814b1a930320025d55da951c7bea4734137f8155582e94ad5bfd3188bb6ae204fc307f25a48708ee57a1ae3425d543b73b1d151af05338350f86053bb914a22ec59eaad3f025c98444914f70b0053f870fcd5b83178e522c3aac63a6902cffcaef788bed25a6b67a27961a7a6c25cdb4b69ba43a5d24fcea949651363ab00aea08f4d3d05322eb26e9fa8e5dc3e95e2c297b5dfbf6f3d47b65de3931d010af1a20bc6e1b1553b240384dc40042af18e02fa4c1fddbbfa9379ac1d304e5fd57155c10da74198274b4e9596d29a047ac71704121cca6ab8adb07f2300ac18cef9244c0a7fae2b2e13d3e048526c4a1cf403f60788b10a8e04bef5acec13f8df10282010100ff7bea91fee79ee2d07365056ae7b31cd65b4d01c6e1ce909330283dc6fd5d089d57f27e7dfbf4dfd311ea697855ebb3d59c8b8a9565997604a853504d9788f5c8cdde1ecf9c0fd04d9c3c97e8bd91cf9dd92e906cf98ac699ce47c5da52a4ecfa5206f114dabda4a229c95fad73b11c42b3770d237dd82f8b955b2c8a109d9186c0d854369dbe62c0e4e5a5703184d00635de528b11f891f8ac2fc8e68eab6137244e580456cb3c78cf24dc7fc0f37ced43b04ab28acf770e708ff05e5c8ccd848a2e9a2d7f01138b823994677190d7b9380ed88231c9de8e535121514186c142b68e743e716ce8538417ef4a710b88b402a44f740b75bbc741d4a9010cdac70282010100c75d20c24b3443c0cc806104d5b5f207ae86e01cc43e69e0c5ee5f7f534c6bf3b4bde005f6ff6c0a96d56ce53196ff942b30408d3f028dafcff75422e254ff09decc4765f9e0555d508d3d60640888da7d3e7029e9b0d38dcfbba60b459adcd58fba2eb1ca84f0510215aaaed94743e40d6b8629279b5b359da2bd612f225c69c3249378761932182ebaf68bb0a6e9deaff9ee63a264ac1780323246b2f2b77bdfe09eda498134aac0cfc50242d791fb1ed60f5125e922d8c017909f7afe1bbcb8a8713f0791fd6c4d82fd12b362046b6affb1af20a379cc7257f9e00c384959d6bddddf443f67ac638bd63f4f9329ab7d5cf44fe0cbe53063835921eba01dc90282010100ed088705953e48479fa6b05f6a6435e5d76b35f324167493e63b93da5d38cc8c258f6748bc927b0afec56c7b164e813484478d9fb2246550fdd93e130f2a3cc3ecde33eada2bacf0525156568a74f7476ce8072fb02b85f9e4d161fdcb254a2723c7def0e5ac5caed65576a3f2459858e3f9a5c6e6dae72c9590a8da95edfc82fc47076e7a8db809df757f2b13009e7c7286a0126d3ceb2663553db0635892e0cb4c3ff3a172f574d1913e5de5999b4e98c36858a575ec2e459361b85d93f87ee52d5f376466a51501267d4d96fbe2aa8309e39c348f05001b84698d43da4bb01ab94d49c4756fd9cd428d02524ab7acc9767a03cd62a484e7c5c80c55111c190282010073566a6c5d8bc822d36cf63410dba9414e741356312696a4867e28db85ba71bdd57400161356a40fe0416b3591a1f50ca88bcadcac7672b8230dc8ac41dac08dda4abe87bdaf4e53a515814bb1b3ca50f522594bb63a29ba22534275c4f81a08a795240c91c8a52b88943661dfac3e17c2b7d12f200dde0fbfb9f5ec3293a379407f799db85d4d40f6500df0b4eb6be3fc5510d8ad8ba69016077454b89479187e65fa20f96379afcbcaa8046ddd3f44540bad62da16eda50e44d3d3a01940bcc6ec14504db5e532720975160b978a4d06e314cde7890c1efe8bed30f480dfd6ccc89d82dc7dfe219a99bd0275ac02f0869f6f6c82f6130b12975bcaa701c4190282010100cb54a6bb5d067cc69b689cb8a718836b271657e9963d51221db06c0af8ff7c0406e416b342941ea1d4038f1825b78c4fa8ecc2a5aa61a50f8280b8923d9fdd113e38e8873107575c7f7896241b29ce0223f66991983c6ee25462a26145a454137daadcf79bb2030ee22954236414cca9e1e40495e30f5daf49bb5c5bddb4ca9a8bf2c00605e8dc41d872268312228dc9c8f6a5e7445e9f8ab5e5f610893fc8bf69ac323e64dab500fa4ce5a487c939d4b80d462f095f2c614e289ce12c9ab496edf9e6bfd35ac354eac5ed0b4ff8463bfb8e0838e4819fa1d8d902c19dd8a11194437a48fb93f08a1d1490275c2abe7fe233afe97f536a0058a2a71e3e2dd680',filePathName);

        tree=mtree(mFileContent);
    else

        [path,fileName,extension]=fileparts(filePathName);
        if startsWith(path,"built-in")




            fileName=fileName(1:end-1);
            me=MException(message(...
            'parallel:gpu:compiler:UnsupportedOperation',fileName));
            throwAsCaller(me);
        end
        if strcmp(extension,'.p')
            me=MException(message(...
            'parallel:gpu:compiler:PcodeUnsupported',...
            fileName,filePathName));
            throwAsCaller(me);
        end


        try



            mFileContent=parallel.internal.gpu.getCode(filePathName);
            tree=mtree(mFileContent);
        catch err



            me=MException(message('parallel:gpu:compiler:AnalysisError',...
            filePathName));

            throwAsCaller(me);
        end
    end

    parallel.internal.tree.sanityCheckTree(tree,filePathName,fcnType,errorMechanism);
end

