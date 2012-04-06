classdef NonPooler < handle & featpipem.pooling.GenericPooler
    
    properties
        subbin_norm_type    % 'l1' or 'l2' (or other value = none)
        norm_type    % 'l1' or 'l2' (or other value = none)
        pool_type    % 'sum' or 'max'
        kermap  % 'homker' (or other value = none [default])
    end
    
    properties(SetAccess=protected)
        encoder_     % implementation of featpipem.encoding.GenericEncoder
    end
    
    methods
        function obj = NonPooler(encoder)
            % set default parameter values
            obj.subbin_norm_type = 'l2';
            obj.norm_type = 'l2';
            obj.pool_type = 'sum';
            obj.kermap = 'none';
            
            % setup encoder
            obj.encoder_ = encoder;
        end
        function dim = get_output_dim(obj)
            bin_count = 1
            dim = bin_count*obj.encoder_.get_output_dim()
            % account for expansion in dimensionality when using kernel map
            if strcmp(obj.kermap,'homker')
                dim = dim*3;
            end
        end
        pcode = compute(obj, imsize, feats, frames)
        %pcode = compute_nopool(obj, imsize, feats, frames)
    end
    
end

