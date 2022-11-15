import 'package:dhis2_dart_utils/dhis2_dart_utils.dart';

void main() {
  // EXAMPLE: program indicator engine
  Map programIndicatorEngineDataObject = {
    "vV9UWAZohSf": 12,
    "qrur9Dvnyt5": 30,
    "GieVkTxp4HH": 0.4,
  };
  List<ProgramIndicator> programIndicators = [
    {
      "id": "yFTplrY7NaL",
      "aggregationType": "CUSTOM",
      "expression":
          "(#{Zj7UnCAulEk.vV9UWAZohSf} * #{Zj7UnCAulEk.GieVkTxp4HH}) + (#{Zj7UnCAulEk.qrur9Dvnyt5})",
      "program": "eBAyeGv0exc"
    },
    {
      "id": "mubfKE304dy",
      "filter":
          "(((#{nabon8T5WUT.lBYgdH4Vgsm} + #{nabon8T5WUT.GR6MYw2N8j0} + #{nabon8T5WUT.JPA34SUEb5z} + #{nabon8T5WUT.sjDqELwGSfi} + #{nabon8T5WUT.OKMP3sU3Y9J} + #{nabon8T5WUT.mwENEUOb5CT} + #{nabon8T5WUT.SCQFC6JZ2N7} + #{nabon8T5WUT.F67XN2zm6uZ} + #{nabon8T5WUT.q1ktvNFG6do} + #{nabon8T5WUT.XEkbQZPXEXc} + #{nabon8T5WUT.uPlWaaySAfh} + #{nabon8T5WUT.ufX2PhOoOQz} + #{nabon8T5WUT.mQSHnvm8nFg} + #{nabon8T5WUT.rdzLjm2WakU} + #{nabon8T5WUT.DpyA3dIIWKZ} + #{nabon8T5WUT.lnWG37kB7sC} + #{nabon8T5WUT.vxnwQ084C41} + #{nabon8T5WUT.AdAfm40LuZK} + #{nabon8T5WUT.rilRaeV5POx} + #{nabon8T5WUT.UBnpoi9rsKS}) / (d2:condition('#{nabon8T5WUT.GR6MYw2N8j0}>=0',2,1)+d2:condition('#{nabon8T5WUT.JPA34SUEb5z}>=0',2,0)+d2:condition('#{nabon8T5WUT.sjDqELwGSfi}>=0',2,0)+d2:condition('#{nabon8T5WUT.OKMP3sU3Y9J}>=0',2,0)+d2:condition('#{nabon8T5WUT.mwENEUOb5CT}>=0',2,0)+d2:condition('#{nabon8T5WUT.SCQFC6JZ2N7}>=0',2,0)+d2:condition('#{nabon8T5WUT.F67XN2zm6uZ}>=0',2,0)+d2:condition('#{nabon8T5WUT.q1ktvNFG6do}>=0',2,0)+d2:condition('#{nabon8T5WUT.XEkbQZPXEXc}>=0',2,0)+d2:condition('#{nabon8T5WUT.lBYgdH4Vgsm}>=0',2,0))) * 100\n) <= 50",
      "aggregationType": "COUNT",
      "expression": "V{event_count}\n",
      "program": "hcFmHC9yXgy"
    }
  ].map((indicator) => ProgramIndicator.fromMap(indicator)).toList();
  print(
    'Evaluation of $programIndicators based on $programIndicatorEngineDataObject = ${ProgramIndicatorEngine.evaluateProgramIndicators(
      programIndicators: programIndicators,
      dataObject: programIndicatorEngineDataObject,
    )}',
  );
}
