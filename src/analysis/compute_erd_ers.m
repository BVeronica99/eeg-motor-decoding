%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function: compute_erd_ers
%
% Description:
% Computes Event-Related Desynchronization / Synchronization (ERD/ERS)
% using the Rest condition as baseline.
%
% Inputs:
%   TF_data - Cell array containing the time-frequency representation of
%             each experimental condition
%
% Outputs:
%   ERDERS_data - Cell array containing normalized ERD/ERS maps
%
% Dependencies:
%   None (uses FieldTrip structures only)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ERDERS_data = compute_erd_ers(TF_data)

%% Baseline

rest_power = TF_data{1}.powspctrm;

%% Initialize output

number_of_conditions = length(TF_data);

ERDERS_data = cell(1, number_of_conditions);

%% Compute ERD/ERS

for condition = 1:number_of_conditions

    ERDERS_data{condition} = TF_data{condition};

    ERDERS_data{condition}.powspctrm = ...
        (TF_data{condition}.powspctrm - rest_power) ./ ...
        (rest_power + eps);

end

fprintf('\nERD/ERS successfully computed using Rest as baseline.\n');

end