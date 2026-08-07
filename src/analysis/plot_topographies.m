%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function: plot_topographies
%
% Description:
% Generates the visualization figures for the ERD/ERS analysis,
% including:
%   1. Time-frequency maps for every channel.
%   2. ERD/ERS scalp topographies.
%
% Inputs:
%   ERDERS_data - Cell array containing ERD/ERS data
%   conditions  - Names of the experimental conditions
%
% Outputs:
%   None
%
% Dependencies:
%   - FieldTrip Toolbox
%   - ft_topoplotTFR
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function plot_topographies(ERDERS_data, conditions)

%% Motor channels

motor_channels = { ...
    'Fz'
    'C3'
    'Cz'
    'C4'
    'Pz'
    'PO7'
    'Oz'
    'PO8'};

%% Time-Frequency Maps

number_of_conditions = length(ERDERS_data);

for condition = 1:number_of_conditions

    time = ERDERS_data{condition}.time;
    freq = ERDERS_data{condition}.freq;
    power = ERDERS_data{condition}.powspctrm;

    for channel = 1:length(motor_channels)

        figure

        imagesc( ...
            time, ...
            freq, ...
            squeeze(power(channel,:,:)));

        axis xy

        colorbar

        colormap("jet")

        title( ...
            ['ERD/ERS Time-Frequency - ' ...
            motor_channels{channel} ...
            ' - ' ...
            conditions{condition}])

        xlabel('Time (s)')
        ylabel('Frequency (Hz)')

        ylim([8 30])

        caxis([-1 1])

    end

end

%% ERD/ERS Topographies

topo_time_window = [0.5 4.5];
topo_frequency_window = [8 30];

for condition = 1:number_of_conditions

    cfg = [];

    cfg.xlim = topo_time_window;

    cfg.ylim = topo_frequency_window;

    cfg.zlim = [-1 1];

    cfg.layout = 'easycapM1';

    cfg.comment = 'no';

    figure

    ft_topoplotTFR(cfg, ERDERS_data{condition});

    colormap("jet")

    colorbar

    title( ...
        ['ERD/ERS Topography - ' ...
        conditions{condition} ...
        ' (8-30 Hz)']);

end

end