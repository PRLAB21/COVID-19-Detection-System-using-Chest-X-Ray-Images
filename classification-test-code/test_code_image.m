format compact; clear; clc;

model_path = 'proposed-CB-STM-RENet-model/Proposed_CB_STM_RENet.mat';
if isfile(model_path)
    fprintf("Model loading...\n");
    load(model_path,'Proposed_CB_STM_RENet');
    fprintf("Model loaded successfully.\n");
    [filepath, cancel] = imgetfile();
    if (~cancel)
        original_image = imread(filepath);
        resized_image = imresize(original_image,[224 224]);
        channels = size(size(resized_image));
        if channels(2) == 2
            resized_image = cat(3, resized_image, resized_image, resized_image);
        end
        disp(size(resized_image));
        fprintf("Running Model on Image.\n");
        [predicted_labels,posterior] = classify(Proposed_CB_STM_RENet,resized_image);
        fprintf("posterior: %f\n", posterior);
        fprintf("predicted_labels: %f\n", predicted_labels);
        label = categorical(predicted_labels);
        if (label == "COVID-19")
            fprintf(' \n COVID-19 Infected \n')
        else
            fprintf(' \n Non-Covid-19 Infected \n')
        end
    else
        fprintf("Invalid Image selected. Valid image is either 304x304 rgb or 156x156 grayscale\n");
    end
else
    fprintf("Model could not be loaded.\n");
end
