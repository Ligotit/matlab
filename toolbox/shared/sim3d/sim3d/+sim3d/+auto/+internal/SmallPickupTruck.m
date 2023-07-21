classdef SmallPickupTruck




    properties(Constant=true)
        FrontBumper=struct(...
        'translation',single([3.0705,0,0.5]),...
        'rotation',single([0,0,0]),...
        'scale',single([1,1,1]));
        RearBumper=struct(...
        'translation',single([-3.0705,0,0.5]),...
        'rotation',single([0,0,pi]),...
        'scale',single([1,1,1]));
        RightMirror=struct(...
        'translation',single([1.10,1.13,1.51]),...
        'rotation',single([0,-pi/2,0]),...
        'scale',single([1,1,1]));
        LeftMirror=struct(...
        'translation',single([1.10,-1.13,1.51]),...
        'rotation',single([0,-pi/2,0]),...
        'scale',single([1,1,1]));
        RearviewMirror=struct(...
        'translation',single([0.85,0.0,1.76]),...
        'rotation',single([0,0,0]),...
        'scale',single([1,1,1]));
        HoodCenter=struct(...
        'translation',single([2.22,0,1.58]),...
        'rotation',single([0,0,0]),...
        'scale',single([1,1,1]));
        RoofCenter=struct(...
        'translation',single([0.0,0,2.26]),...
        'rotation',single([0,0,0]),...
        'scale',single([1,1,1]));
    end

end