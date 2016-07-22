%% getDescriptors_SIFT.m --- 
% 
% Filename: getKeypoints_SIFT.m
% Description: Wrapper Function for SIFT
% Author: Kwang Moo Yi, Yannick Verdie
% Maintainer: Kwang Moo Yi, Yannick Verdie
% Created: Tue Jun 16 17:20:35 2015 (+0200)
% Version: 
% Package-Requires: ()
% URL: 
% Doc URL: 
% Keywords: 
% Compatibility: 
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%% Commentary: 
% 
% 
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%% Change Log:
% 
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%% Code:


function [keypts] = getKeypoints_SIFT(img_info, p)
    methodName = strsplit(mfilename,'_');
    methodName = methodName{end};
    
    param_nameKp =  p.optionalParametersKpName;
    out = [img_info.full_feature_prefix '_' methodName '_keypoints-' param_nameKp '-txt'];
    if ~exist(out, 'file')
        fprintf(['File with features does not exist: "' out '"\n']);
        
        in = img_info.image_name;
        in = strrep(in, 'image_gray', 'image_color');
        try
            opencvDetector(methodName, in, out);
        catch
            fprintf('\nCould not run "opencvDetector" directly, trying with system()...\n');
            
            VENV = getenv('VIRTUAL_ENV');
            if ~strcmpi(VENV, '')
                prefix = ['LD_LIBRARY_PATH=' VENV '/lib/'];
            else
                prefix = ['LD_LIBRARY_PATH='];
            end
            com = ['(cd ../external/src/OpenCVWrapper/;' prefix '; ./opencvDetector ' methodName ' ' in ' ' out ')'];
            [status, cmdout] = system(com);
            
            if status ~= 0
                fprintf('\n');
                error('Error when running "opencvDetector" with system(): \n%sRun "benchmark-orientation/matlab/external/methods/opencvDetector.py" python script to extract features first!\n', cmdout);                
            end
        end

    end
   
    [keypts, ~, ~] = loadFeatures(out);
    keypts = keypts';

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% getKeypoints_SIFT.m ends here
