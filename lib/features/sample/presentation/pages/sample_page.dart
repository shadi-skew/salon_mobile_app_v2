import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_mobile_app_v2/core/widgets/error_widget.dart';
import 'package:salon_mobile_app_v2/features/sample/presentation/manager/sample_bloc.dart';
import 'package:salon_mobile_app_v2/features/sample/presentation/manager/sample_event.dart';
import 'package:salon_mobile_app_v2/features/sample/presentation/manager/sample_state.dart';

/// Sample page demonstrating the architecture pattern
class SamplePage extends StatelessWidget {
  const SamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salon App'),
      ),
      body: BlocBuilder<SampleBloc, SampleState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(
              child: Text('Welcome to Salon App'),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            success: (items) => ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  title: Text(item.title),
                  subtitle: Text(item.description),
                  trailing: Icon(
                    item.isCompleted
                        ? Icons.check_circle
                        : Icons.circle_outlined,
                    color: item.isCompleted ? Colors.green : Colors.grey,
                  ),
                );
              },
            ),
            error: (error) => AppErrorWidget(
              error: error,
              onRetry: () {
                context
                    .read<SampleBloc>()
                    .add(const SampleEvent.refreshItems());
              },
            ),
          );
        },
      ),
    );
  }
}
