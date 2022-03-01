import 'package:chuck_norris/src/domain/mappers/mapper.dart';

abstract class ReverseMapper<Input, Output> extends Mapper<Input, Output> {
  Input reverseMap(Output input);
}
