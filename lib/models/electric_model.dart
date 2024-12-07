class ElectricModel {
  String? lastDeviceReadDate;
  double? totalIndexGrid;
  double? totalIndexGridCost;
  double? gridBalance;
  double? gridBalanceCost;
  double? totalIndexGenerator;
  double? totalIndexGeneratorCost;
  double? generatorBalance;
  double? generatorBalanceCost;
  bool? relayStatus;
  String? powerSource;
  List<PreviousGeneratorReading>? previousGeneratorReading;

  ElectricModel({
    this.lastDeviceReadDate,
    this.totalIndexGrid,
    this.totalIndexGridCost,
    this.gridBalance,
    this.gridBalanceCost,
    this.totalIndexGenerator,
    this.totalIndexGeneratorCost,
    this.generatorBalance,
    this.generatorBalanceCost,
    this.relayStatus,
    this.powerSource,
    this.previousGeneratorReading,
  });

  ElectricModel.fromJson(Map<String, dynamic> json) {
    lastDeviceReadDate = json['last_device_read_date'];
    totalIndexGrid = (json['total_index_grid'] as num?)?.toDouble();
    totalIndexGridCost = (json['total_index_grid_cost'] as num?)?.toDouble();
    gridBalance = (json['grid_balance'] as num?)?.toDouble();
    gridBalanceCost = (json['grid_balance_cost'] as num?)?.toDouble();
    totalIndexGenerator = (json['total_index_generator'] as num?)?.toDouble();
    totalIndexGeneratorCost =
        (json['total_index_generator_cost'] as num?)?.toDouble();
    generatorBalance = (json['generator_balance'] as num?)?.toDouble();
    generatorBalanceCost = (json['generator_balance_cost'] as num?)?.toDouble();
    relayStatus = json['relay_status'];
    powerSource = json['power_source'];
    if (json['previous_generator_reading'] != null) {
      previousGeneratorReading = <PreviousGeneratorReading>[];
      json['previous_generator_reading'].forEach((v) {
        previousGeneratorReading!.add(PreviousGeneratorReading.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['last_device_read_date'] = lastDeviceReadDate;
    data['total_index_grid'] = totalIndexGrid;
    data['total_index_grid_cost'] = totalIndexGridCost;
    data['grid_balance'] = gridBalance;
    data['grid_balance_cost'] = gridBalanceCost;
    data['total_index_generator'] = totalIndexGenerator;
    data['total_index_generator_cost'] = totalIndexGeneratorCost;
    data['generator_balance'] = generatorBalance;
    data['generator_balance_cost'] = generatorBalanceCost;
    data['relay_status'] = relayStatus;
    data['power_source'] = powerSource;
    if (previousGeneratorReading != null) {
      data['previous_generator_reading'] =
          previousGeneratorReading!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PreviousGeneratorReading {
  String? date;
  double? firstGeneratorBalance;
  double? lastGeneratorBalance;
  double? generatorConsumption;
  double? generatorConsumptionCost;

  PreviousGeneratorReading({
    this.date,
    this.firstGeneratorBalance,
    this.lastGeneratorBalance,
    this.generatorConsumption,
    this.generatorConsumptionCost,
  });

  PreviousGeneratorReading.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    firstGeneratorBalance =
        (json['first_generator_balance'] as num?)?.toDouble();
    lastGeneratorBalance = (json['last_generator_balance'] as num?)?.toDouble();
    generatorConsumption = (json['generator_consumption'] as num?)?.toDouble();
    generatorConsumptionCost =
        (json['generator_consumption_cost'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['first_generator_balance'] = firstGeneratorBalance;
    data['last_generator_balance'] = lastGeneratorBalance;
    data['generator_consumption'] = generatorConsumption;
    data['generator_consumption_cost'] = generatorConsumptionCost;
    return data;
  }
}
