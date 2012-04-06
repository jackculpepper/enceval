function pcode = compute(obj, imsize, feats, frames)
%COMPUTE Pool features using the spatial pyramid match kernel
    % check pool type is valid
    if ~strcmp(obj.pool_type,'sum') && ~strcmp(obj.pool_type,'max')
        error('pool_type must be either ''sum'' or ''max''');
    end

    bin_count = 1;
    
    pcode = single(zeros(obj.encoder_.get_output_dim(),bin_count));
    code = obj.encoder_.encode(feats);
    if nnz(isnan(code)), error('Code contains NaNs'); end
    pcode = code;
    
    pcode = pcode(:);
    
    % now normalize whole code
    if strcmp(obj.norm_type,'l2')
        pcode = pcode/norm(pcode,2);
    end
    if strcmp(obj.norm_type,'l1')
        pcode = pcode/norm(pcode,1);
    end
    
    % now apply kernel map if specified
    % (note: when adding extra kernel maps, note that the getDim function
    % must also be modified to reflect the appropriate increase in code
    % dimensionality)
    if strcmp(obj.kermap,'homker')
        pcode = vl_homkermap(pcode, 1, 'kchi2');
    end
end

